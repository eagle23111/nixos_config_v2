{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WRL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

}
