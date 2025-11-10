{
  pkgs,
  inputs,
  ...
}:
{
  home.file.".config/rofi" = {
    source = inputs.dotfiles + "/.config/rofi";
    recursive = true;
  };

  home.packages = [
    pkgs.rofi
    pkgs.nerd-fonts.terminess-ttf
    pkgs.nerd-fonts.inconsolata
  ];
}
