{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  zen-alias = pkgs.writeShellScriptBin "zen-browser" ''
    		#!/usr/bin/env bash
    		zen
    	'';
in
{
  imports = [
    ./kitty.nix
    ./rofi.nix
    ./wal.nix
    ./waybar.nix
  ];
  home.file = {
    ".config/hypr" = {
      source = inputs.dotfiles + "/.config/hypr";
      recursive = true;
    };
  };

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  home.packages = with pkgs; [
    zen-alias
    swww
    swaylock
    hypridle
    blueman
    wayland
    udiskie
    swaynotificationcenter
    networkmanagerapplet
    pavucontrol
    hyprcursor
    hyprland
    hyprshade
    inputs.zen-browser.packages."${system}".default
    kitty
    figlet
    lolcat
    uwsm
    xdg-desktop-portal-hyprland
  ];

  catppuccin.enable = true;
  fonts.fontconfig = {
    enable = true;
  };

  gtk.enable = true;

  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Classic";

  gtk.theme.package = pkgs.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";

  #  gtk.iconTheme.package = pkgs.gruvbox-dark-gtk;
  #  gtk.iconTheme.name = "gruvbox-dark";

  qt.enable = true;
  qt.platformTheme.name = "gtk2";
  qt.style.name = "kvantum";
  #qt.style.package = pkgs.adwaita-qt;

}
