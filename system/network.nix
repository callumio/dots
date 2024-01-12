{ config, pkgs, ... }: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowPing = true;
    enableIPv6 = false;
  };
}
