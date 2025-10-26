{config, lib, pkgs, inputs, ...}:
{

  home.file = {
    ".config/hypr" = {
      source = inputs.dotfiles + "/.config/hypr";
      recursive = true;
    };
    ".config/kitty" = {
      source = inputs.dotfiles + "/.config/kitty";
      recursive = true;
    };
    ".config/wal" = {
      source = inputs.dotfiles + "/.config/wal";
      recursive = true;
    };
    ".config/waybar" = {
      source = inputs.dotfiles + "/.config/waybar";
      recursive = true;
    };
  };
 
  programs.zsh.initExtra = ''
    if [ -z "$SSH_CONNECTION" ] && uwsm check may-start; then
      figlet -f starwars "welcome" | lolcat -p 2 -F 0.2
      echo "Starting uwsm default..."
      uwsm start default > /dev/null
    fi
    '';

  home.packages = with pkgs; [
    swww
    rofi
    swaylock
    waybar
    hypridle
    blueman
    udiskie
    swaynotificationcenter
    networkmanagerapplet
    pavucontrol
    hyprcursor
    hyprshade
    inputs.zen-browser.packages."${system}".default
    pywal16

    jetbrains-mono
    nerd-fonts.terminess-ttf 
    terminus_font
    nerd-fonts.inconsolata
    dejavu_fonts 

    figlet
    lolcat
  ];

  fonts.fontconfig.enable = true;

  gtk.enable = true;
	
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Classic";
	
  gtk.theme.package = pkgs.gnome-themes-extra;
  gtk.theme.name = "Adwaita-dark";
	
  gtk.iconTheme.package = pkgs.gruvbox-dark-gtk;
  gtk.iconTheme.name = "gruvbox-dark";
	
  qt.enable = true;
  qt.platformTheme.name = "gtk2";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

}
