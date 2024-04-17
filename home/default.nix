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
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
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
    rustup
    ripgrep
    zig
    ghc
    xh
    unzip
    just
    inputs.nixvim.packages."x86_64-linux".default # nixvim
  ];

  home.stateVersion = "23.11";
}
