{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "mortal";
  home.homeDirectory = "/home/mortal";

  programs.chromium.enable = true;
  home.packages = with pkgs; [
    # Gaming Tools
    steam # A popular platform for playing and managing games
    protonup-qt # A tool for managing proton versions
    gamemode # Enhances gaming performance by adjusting system settings automatically
    gamescope
    lutris # A game manager that supports running games on Linux, including Windows (via wine)
    prismlauncher
    inputs.zen-browser.packages.${system}.default
    wineWowPackages.stable
    winetricks
    zsh
    vscode
    # System Utilities
    which # Displays the full path of executable commands
    tree # Prints directory trees in a hierarchical format
    transmission_4-gtk

    tor
    tor-browser

    libreoffice-fresh
    jre8

    # Shells
    zsh # A powerful shell with advanced features

    # Programming/Development Tools
    devenv
    openssl
    #busybox

    # AI/ML Tools
    nodePackages.nodejs # JavaScript runtime environment (version 23)
    llama-cpp
    lmstudio
    inputs.nvchad4nix.packages.${system}.default
    # -----
    hydrus
    aria2
    fastfetch
    qimgv
    mpv
    gimp
    kitty
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "eagle23111";
      email = "stasapohta@yandex.ru";
    };
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
