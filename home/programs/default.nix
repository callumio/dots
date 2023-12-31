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
    ./nvim
    ./tmux
    ./alacritty
  ];

  programs = { gpg.enable = true; };
}
