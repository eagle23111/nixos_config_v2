{
  pkgs,
  inputs,
  ...
}:
{
  home.file.".config/kitty" = {
    source = inputs.dotfiles + "/.config/kitty";
    recursive = true;
  };
  home.packages = [ pkgs.kitty ];
}
