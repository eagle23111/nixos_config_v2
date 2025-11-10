{
  pkgs,
  inputs,
  ...
}:
{

  home.file.".config/waybar" = {
    source = inputs.dotfiles + "/.config/waybar";
    recursive = true;
  };

  home.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.terminess-ttf
    terminus_font
    nerd-fonts.inconsolata
    dejavu_fonts
    waybar
  ];

}
