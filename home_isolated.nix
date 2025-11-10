{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "isolateduser";
  home.homeDirectory = "/home/isolateduser";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
