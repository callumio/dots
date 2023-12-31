{ config, pkgs, ... }: {
  networking = {
    hostName = "artemis";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowPing = true;
    enableIPv6 = false;
  };
}
