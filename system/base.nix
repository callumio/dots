{ inputs, config, pkgs, ... }:

{
  environment = {
    variables = { EDITOR = "nvim"; };
    sessionVariables = { NIXOS_OZONE_WL = "1"; };

    shells = with pkgs; [ fish ];

    etc."greetd/environments".text = ''
      hyprland
    '';
  };

  virtualisation.libvirtd.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  services = {
    dbus.enable = true;
    printing.enable = true;
    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    thermald.enable = true;
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
    greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd Hyprland
        '';
      };
    };
  };

  powerManagement.powertop.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.c = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    packages = with pkgs; [ ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.nm-applet.enable = true;

  sound.enable = true;
  security.rtkit.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
