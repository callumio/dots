{ inputs, config, pkgs, ... }:

{
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
  ];

  programs = { gpg.enable = true; };
}
