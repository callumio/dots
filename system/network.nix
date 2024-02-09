{ config, pkgs, ... }: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowPing = true;
    enableIPv6 = false;
    nameservers = [ "9.9.9.9" "4.4.4.4" ];
  };
}
