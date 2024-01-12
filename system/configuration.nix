{ config, lib, pkgs, ... }:

{
  imports = [
    ./network.nix
    ./packages.nix
    ./base.nix

  ];
  system.stateVersion = "23.11";

}
