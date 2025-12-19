{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # === Imports ===
  imports = [
    ./nixos-modules/hyprland.nix
    ./basic_programs.nix
    #./nixos-modules/nix-ld.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # === Boot Configuration ===
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  boot.kernelModules = [ "ecryptfs" ];
  boot.extraModprobeConfig = ''
    		options hid_apple fnmode=2
    	'';

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    timeoutStyle = "hidden";
  };

  # === Environment Variables ===
  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  # === Networking Configuration ===
  networking.hostName = "Nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";

  # === Internationalization Configuration ===
  i18n.defaultLocale = "en_US.UTF-8";

  # === Console Configuration ===
  console.useXkbConfig = true;

  # === X Server Configuration ===
  services.xserver.xkb = {
    layout = "us,ru";
    options = "eurosign:e,grp:alt_shift_toggle";
  };

  # === Audio and Bluetooth Configuration ===
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.general = {
      Experimental = true;
    };
  };

  # === User Configuration ===
  users.users.mortal = {
    isNormalUser = true;
    uid = 1000;
    group = "mortal";
    extraGroups = [
      "wheel"
      "libvirtd"
      "docker"
        "wireshark"
    ];
  };
  users.users.isolateduser = {
    isNormalUser = true;
    uid = 1001;
    group = "isolateduser";
  };

  users.groups.mortal = {
    gid = 1000;
  };
  users.groups.isolateduser = {
    gid = 1001;
  };

  nix.settings.trusted-users = [
    "root"
    "mortal"
  ];
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  services.nfs.server.enable = true;
  programs.ecryptfs.enable = true;
  security.pam.enableEcryptfs = true;

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
  };

  # === SSH Configuration ===
  services.openssh.enable = true;

  # === State Version ===
  system.stateVersion = "24.11";
}
