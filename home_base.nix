{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt # A tool for managing proton versions
    gamemode # Enhances gaming performance by adjusting system settings automatically
    gamescope
    lutris # A game manager that supports running games on Linux, including Windows (via wine)

    wineWowPackages.stable
    winetricks
    vscode

    # Shells
    zsh # A powerful shell with advanced features

    inputs.nvchad4nix.packages.${system}.default

    fastfetch
    qimgv
    mpv
    gimp
  ];
}
