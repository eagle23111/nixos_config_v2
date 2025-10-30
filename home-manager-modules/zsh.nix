{config, pkgs,...}:

let
  hydrusDBpath = "/mnt/media_1/hydrus/db";
  http_proxy = "http://192.168.0.50:3128";
in 
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
	    enable = true;
	    theme = "robbyrussell";
	    plugins = [
	    "git"
	    # "docker"
	    ];
	  };
  };
  
  home.shellAliases = {
    hydrus = "env --unset=WAYLAND_DISPLAY --unset=QT_QPA_PLATFORM hydrus-client -d ${hydrusDBpath}";
    proxyrun = "HTTP_PROXY=${http_proxy} http_proxy=${http_proxy} HTTPS_PROXY=${http_proxy} https_proxy=${http_proxy}";
  };
}
