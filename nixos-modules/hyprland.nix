{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;    
  };
  
  services.udisks2.enable = true;

  environment.sessionVariables = {
    WRL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  
  services.displayManager.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
    wl-clipboard-x11
  ];

  security.pam.services.swaylock = {};
 
  services.blueman.enable = true;

}
