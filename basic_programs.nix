{ pkgs, ... }:
{
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    neovim
    which
    tree
    btop
    iotop
    iftop
    strace
    ltrace
    lsof

    nix-index

    zip
    xz
    unzip
    p7zip
    xarchiver

    lm_sensors
    ethtool
    pciutils
    usbutils
    nixfmt-rfc-style

    wl-clipboard
    wl-clipboard-x11

    winboat
    shotman
    freerdp

  ];
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.emoji = [
        "twemoji-color-font"
        "twitter-color-emoji"
      ];
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      twemoji-color-font
      twitter-color-emoji
    ];
  };
  programs.zsh.enable = true;
  programs.git.enable = true;
  services.nfs.server.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
  services.udisks2.enable = true;

  environment.sessionVariables = {
    WRL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  services.displayManager.enable = true;
  services.flatpak.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];
  };

  security.pam.services.swaylock = { };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = false;
      setSocketVariable = true;
    };
  };

  programs.proxychains = {
    enable = true;
    proxies = {
      zapretproxy = {
	enable = true;
        type = "socks5";
        host = "192.168.0.50";
        port = 1080;
      };
    };
    chain.type = "dynamic";
  };

	programs.wireshark = {
		enable = true;
		package = pkgs.wireshark;
	};

  nixpkgs.overlays = [
    (import ./overlays/llamacpp.nix)
    (import ./overlays/hydrus.nix)
  ];

}
