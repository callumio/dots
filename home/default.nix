{ inputs, config, pkgs, ... }:

{
  imports =
    [ inputs.hyprland.homeManagerModules.default ./programs ./services ];

  programs.home-manager.enable = true;

  home = {
    username = "c";
    homeDirectory = "/home/c";
  };

  sops = {
    age.sshKeyPaths = [ "/home/c/.ssh/id_ed25519" ];
    defaultSopsFile = ./secrets.yaml;
    secrets = { };
  };

  home.packages = with pkgs; [
    bitwarden
    wl-clipboard
    webcord
    brightnessctl
    playerctl
    pavucontrol
    tldr
    grc
    fd
    rofi-rbw-wayland
    wtype
    mullvad-vpn
    spotify
    gnumake
    delta
    slurp
    grim
    clang-tools
    clang
    ghq
    gst
    udiskie
    cargo
    cargo-watch
    rustc
    xh
  ];

  home.stateVersion = "23.11";
}
