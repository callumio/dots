{
  inputs,
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {General = {Enable = "Source,Sink,Media,Socket";};};
  };

  services = {
    blueman.enable = true;

    power-profiles-daemon.enable = false;
    system76-scheduler.settings.cfsProfiles.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
  };

  programs.seahorse.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };
  };

  networking = {hostName = "artemis";};
}
