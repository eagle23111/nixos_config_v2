{ config, pkgs, inputs, ... }:


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
    which # Displays the full path of executable commands
    tree # Prints directory trees in a hierarchical format

    
    # Compression Tools
    zip # Compresses files into .zip format
    xz # Compresses/decompresses files using XZ format
    unzip # Extracts files from .zip archives
    p7zip # Handles 7-zip compressed files
    xarchiver

    # Shells
    zsh # A powerful shell with advanced features
    
    # Programming/Development Tools
    sysstat # Provides tools for monitoring system performance
    lm_sensors # Monitors hardware sensors (CPU, RAM, temperatures)
    ethtool # Configures and displays Ethernet device information
    pciutils # Tools for managing and querying PCI devices
    usbutils # Utilities for USB devices management

	  inputs.nvchad4nix.packages.${system}.default
    
    fastfetch
    qimgv
    mpv
    gimp

];
  
  programs.git = {
    enable = true;
    userName = "eagle23111";
    userEmail = "stasapohta@yandex.ru";
  };


  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

