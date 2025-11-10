{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ./rofi.nix ];
  programs.zsh.initContent = ''
    if [ -z "$SSH_CONNECTION" ] && uwsm check may-start; then
      figlet -f starwars "welcome" | lolcat -p 2 -F 0.2
      echo "Starting uwsm default..."
      uwsm start niri > /dev/null
    fi
  '';
}
