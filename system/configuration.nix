{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./packages.nix
    ./base.nix

  ];
  system.stateVersion = "23.11";

}
