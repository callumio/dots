{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./network.nix
    ./packages.nix
    ./base.nix
  ];
  system.stateVersion = "24.05";
}
