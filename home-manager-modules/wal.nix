{
  pkgs,
  inputs,
  ...
}:
{
  home.file.".config/wal" = {
    source = inputs.dotfiles + "/.config/wal";
    recursive = true;
  };

  home.packages = [ pkgs.pywal16 ];
}
