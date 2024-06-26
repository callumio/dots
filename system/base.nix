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

  services = {
    dbus.enable = true;
    printing.enable = true;

    udisks2.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    thermald.enable = true;
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
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "dialout" ];
    packages = with pkgs; [ ];
  };

  programs.hyprland = { enable = true; };

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
