{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hypr
    ./waybar
    ./git
    ./fish
    ./wpaperd
    ./rofi
    ./rbw
    ./firefox
    ./tmux
    ./alacritty
    ./direnv
  ];

  programs = {gpg.enable = true;};
}
