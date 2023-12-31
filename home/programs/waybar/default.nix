{ config, inputs, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      hyprlandSupport = true;
      swaySupport = false;
    };
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 28;
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "wireplumber" "backlight" "battery" "clock" "tray" ];
        clock = {
          tooltip = false;
          interval = 1;
          format = "{:%H:%M}";
          format-alt = "{:%d %B %Y, %A}";
        };
        battery = {
          states = {
            good = 90;
            warning = 30;
            critical = 10;
          };
          format = "{capacity}%";
          tooltip = false;
        };
        wireplumber = {
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          tooltip = false;
        };
        tray = { spacing = 4; };
      };
    };
  };
}
