{ pkgs, ... }:
{
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
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  programs.zsh.enable = true;
  programs.git.enable = true;
  services.nfs.server.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
}
