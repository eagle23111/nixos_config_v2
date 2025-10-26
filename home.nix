{ config, pkgs, inputs, ... }:


{
  home.username = "mortal";
  home.homeDirectory = "/home/mortal";
  


  imports = [
    ./home-manager-modules/zsh.nix
    ./home-manager-modules/hyprland-user.nix
  ];

  programs.chromium.enable = true;
  home.packages = with pkgs; [
    # Gaming Tools
    steam # A popular platform for playing and managing games
    protonup-qt # A tool for managing proton versions
    gamemode # Enhances gaming performance by adjusting system settings automatically
    gamescope
    lutris # A game manager that supports running games on Linux, including Windows (via wine)
    prismlauncher

    wineWowPackages.stable
    winetricks
    zsh
    vscode
    # System Utilities
    which # Displays the full path of executable commands
    tree # Prints directory trees in a hierarchical format
    nix-output-monitor # Monitors NixOS system outputs (exact function unclear)
    transmission_4-gtk

    # Networking Tools
    iperf3 # Network bandwidth testing tool
    dnsutils # Tools for querying and troubleshooting DNS
    nmap # Network scanning and security auditing tool
    ipcalc # Calculates IP addresses and subnets
    
    # Monitoring Tools
    btop # Lightweight monitoring tool for processes, CPU, memory, etc.
    iotop # Monitoring I/O usage by processes
    iftop # Monitoring network interface traffic
    strace # Traces system calls made by a process
    ltrace # Traces library calls and arguments of a process
    lsof # Lists open files and the processes that opened them
    libreoffice-fresh
    jre8

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
    devenv
    openssl
    #busybox
    libvirt
    virt-manager
    qemu
    usbredir

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

];
  
  programs.git = {
    enable = true;
    userName = "eagle23111";
    userEmail = "stasapohta@yandex.ru";
  };


  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

