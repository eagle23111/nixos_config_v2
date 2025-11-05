{ config, pkgs, ... }:

let
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
  catppuccin.zsh-syntax-highlighting.enable = false;
  home.shellAliases = {
    proxyrun = "HTTP_PROXY=${http_proxy} http_proxy=${http_proxy} HTTPS_PROXY=${http_proxy} https_proxy=${http_proxy}";
  };
}
