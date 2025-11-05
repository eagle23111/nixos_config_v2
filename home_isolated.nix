{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "isolateduser";
  home.homeDirectory = "/home/isolateduser";

  imports = [
    ./home-manager-modules/zsh.nix
    ./home-manager-modules/hyprland-user.nix
  ];

  home.packages = with pkgs; [
    protonup-qt # A tool for managing proton versions
    gamemode # Enhances gaming performance by adjusting system settings automatically
    gamescope
    lutris # A game manager that supports running games on Linux, including Windows (via wine)

    wineWowPackages.stable
    winetricks
    vscode
    # System Utilities

    # Shells
    zsh # A powerful shell with advanced features

    # Programming/Development Tools

    inputs.nvchad4nix.packages.${system}.default

    fastfetch
    qimgv
    mpv
    gimp

  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
