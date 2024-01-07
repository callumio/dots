{ config, inputs, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { TERM = "xterm-256color"; };
      font = { size = 12.5; };
    };
  };
}
