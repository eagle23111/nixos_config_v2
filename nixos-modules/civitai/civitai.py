#!/usr/bin/env python
import os
import sys
import argparse
import requests
from tqdm import tqdm
from dotenv import load_dotenv
from urllib.parse import urlparse, parse_qs
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
load_dotenv()

def get_civitai_api_key():
    """Retrieve the CivitAI API key from environment variables."""
    token = os.getenv("CIVITAI_API_KEY")
    if not token:
        raise ValueError("CIVITAI_API_KEY is not set in environment variables.")
    return token

def sanitize_filename(name):
    """Sanitize filenames to be safe for filesystems and remove special characters."""
    name = name.replace("/", " ")
    name = ''.join([c if ord(c) < 128 else ' ' for c in name])
    invalid_chars = '<>:"/\\|?*'
    for char in invalid_chars:
        name = name.replace(char, '_')
    return name

def extract_model_version_id(input_str):
    """Extract model version ID from various input formats."""
    try:
        return int(input_str)
    except ValueError:
        pass
    
    parsed_url = urlparse(input_str.strip())
        
    if "civitai.com" not in parsed_url.netloc:
        raise ValueError(f"URL does not appear to be a CivitAI URL: {input_str}")
    
    query_params = parse_qs(parsed_url.query)
    if 'modelVersionId' in query_params:
        model_id_str = query_params['modelVersionId'][0]
        try:
            return int(model_id_str)
        except ValueError:
            pass
    
    path_parts = parsed_url.path.split('/')
    if len(path_parts) >= 5 and path_parts[1] == 'api' and \
       path_parts[2] == 'download' and path_parts[3] == 'models':
        model_id_str = path_parts[4]
        try:
            return int(model_id_str)
        except ValueError:
            pass
    
    raise ValueError(f"Could not extract model version ID from: {input_str}")

def create_directory(save_path, model_type):
    """Create necessary directories for saving the model."""
    base_dir = os.path.join(os.getcwd() if not os.path.isabs(save_path) else save_path,
                           'models', model_type)
    os.makedirs(base_dir, exist_ok=True)
    return base_dir

def download_model_files(model_version_id, save_path):
    """Download individual files for the given model version."""
    headers = {
        "Authorization": f"Bearer {get_civitai_api_key()}",
        "User-Agent": "MyBasicDownloader/1.0"
    }

    response = requests.get(
        f"https://civitai.com/api/v1/model-versions/{model_version_id}",
        headers=headers,
    )

    if not response.ok:
        raise requests.HTTPError(f"Failed to fetch model version {model_version_id}: {response.status_code}")

    model_data = response.json()
    
    for file_info in model_data.get("files", []):
        download_url = file_info.get("downloadUrl")
        if not download_url:
            continue
            
        model_type = model_data.get("model", {}).get("type", None)
        format_enum = file_info.get("metadata", {}).get("format", "undefined")

        type_to_path = {
            "Checkpoint": "checkpoints",
            "TextualInversion": "embeddings",
            "Hypernetwork": "hypernetworks",
            "LORA": "loras",
            "LoCon": "loras",
            "Controlnet": "controlnet"
        }

        if not model_type or model_type not in type_to_path:
            logger.warning(f"Unsupported model type: {model_type}. Skipping this file.")
            continue
            
        save_dir = os.path.join(save_path, type_to_path[model_type])
        os.makedirs(save_dir, exist_ok=True)
        
        general_name = model_data.get("model", {}).get("name", "unknown")
        specific_name = file_info.get('name', 'unnamed_file')
        extension = {
            "SafeTensor": ".safetensors",
            "PickleTensor": ".pt",
            "Other": ".bin"
        }.get(format_enum, "")
        
        filename = f"{general_name}_{specific_name}"
        safe_filename = sanitize_filename(filename)
        save_full_path = os.path.join(save_dir, safe_filename)

        logger.info(f"Downloading: {safe_filename}")
        
        response = requests.get(download_url, stream=True, headers=headers)
        if not response.ok:
            raise requests.HTTPError(f"Failed to download file {filename}: {response.status_code}")

        total_size = int(response.headers.get('Content-Length', 0))
        
        with open(save_full_path, 'wb') as f:
            with tqdm(
                total=total_size,
                unit='B',
                unit_scale=True,
                unit_divisor=1024,
                desc=f"Downloading {safe_filename}"
            ) as progress_bar:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
                    progress_bar.update(len(chunk))
        
        logger.info(f"Download completed: {save_full_path}")

def main():
    parser = argparse.ArgumentParser(
        description='Download models from CivitAI by version IDs or URLs.',
        formatter_class=argparse.RawTextHelpFormatter,
        epilog='''
        Examples:
          - Direct ID: python script.py 12345
          - URL with query parameter: python script.py https://civitai.com/models/...?modelVersionId=6789
          - Download URL: python script.py https://civitai.com/api/download/models/123456
        ''')
    
    parser.add_argument(
        'inputs',
        nargs='+',
        help='Model version IDs or CivitAI URLs (space-separated)'
    )
    
    parser.add_argument(
        '--save-path', 
        type=str, 
        default="/mnt/media_1/ComfyUI/models",
        help='Path where to save the downloaded models (default: ./models)'
    )

    parser.add_argument(
        '--disable-progress',
        action='store_true',
        help='Disable progress bars'
    )
    
    args = parser.parse_args()

    try:
        model_ids = []
        for input_str in args.inputs:
            model_id = extract_model_version_id(input_str)
            if model_id is None:
                logger.error(f"Invalid input format - could not extract model version ID from: {input_str}")
                sys.exit(1)
            model_ids.append(model_id)

        for model_id in model_ids:
            try:
                download_model_files(model_version_id=model_id, save_path=args.save_path)
            except Exception as e:
                logger.error(f"Failed to download model {model_id}: {str(e)}")
                raise

    except KeyboardInterrupt:
        logger.info("\nDownload canceled by user.")
        sys.exit(0)

if __name__ == "__main__":
    main()
