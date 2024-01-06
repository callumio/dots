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
        height = 20;
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right =
          [ "temperature" "wireplumber" "backlight" "battery" "clock" "tray" ];
        clock = {
          tooltip = false;
          interval = 1;
          format = "{:%H:%M}";
          format-alt = "{:%d %B %Y, %A}";
        };
        battery = {
          states = {
            full = 99;
            good = 98;
            normal = 98;
            warning = 20;
            critical = 10;
          };
          format = "{icon}  {capacity}%";
          format-good = "{icon}  {capacity}%";
          format-full = "  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };
        wireplumber = {
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}  {volume}%";
          format-muted = "";
          format-icons = [ "" "" "" ];
          tooltip = false;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" ];
          tooltip = false;
        };
        tray = {
          icon-size = 18;
          spacing = 4;
          show-passive-items = true;
          tooltip = false;
        };
        temperature = {
          thermal-zone = 0;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" ];
          interval = 30;
          tooltip = false;
        };
      };
    };

    style = let
      base00 = "#282c34";
      base01 = "#353b45";
      base02 = "#3e4451";
      base03 = "#545862";
      base04 = "#565c64";
      base05 = "#abb2bf";
      base06 = "#b6bdca";
      base07 = "#c8ccd4";
      base08 = "#e06c75";
      base09 = "#d19a66";
      base0A = "#e5c07b";
      base0B = "#98c379";
      base0C = "#56b6c2";
      base0D = "#61afef";
      base0E = "#c678dd";
      base0F = "#be5046";
    in ''
      @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};

      @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

      * {
           font-family: "monospace";
           font-size: 13px;
           min-height: 0;
           border: none;
           border-radius: 0;
           margin: 0px;
      }
      window#waybar, tooltip {
           background: alpha(@base00, 1);
           color: @base05;
      }
      tooltip {
           border-color: @base0D;
      }
      #workspaces button {
           border-bottom: 3px solid transparent;
           margin: 0px;
           padding: 0 5px;
           color: @base05;
      }
      #workspaces button.focused, #workspaces button.active {
           border-bottom: 3px solid @base05;
      }
      #workspaces button:hover {
           background: alpha(@base05, 1);
           color: @base00;
      }
      #wireplumber {
           padding: 0 5px;
      }
      #wireplumber.muted {
           padding: 0 5px;
      }
      #upower, #battery {
           padding: 0 5px;
      }
      #upower.charging, #battery.Charging {
           padding: 0 5px;
      }
      #network {
           padding: 0 5px;
      }
      #network.disconnected {
           padding: 0 5px;
      }
      #user {
           padding: 0 5px;
      }
      #clock {
           padding: 0 5px;
      }
      #backlight {
           padding: 0 5px;
      }
      #cpu {
           padding: 0 5px;
      }
      #disk {
           padding: 0 5px;
      }
      #idle_inhibitor {
           padding: 0 5px;
      }
      #temperature {
           padding: 0 5px;
      }
      #mpd {
           padding: 0 5px;
      }
      #language {
           padding: 0 5px;
      }
      #keyboard-state {
           padding: 0 5px;
      }
      #memory {
           padding: 0 5px;
      }
      #window {
           padding: 0 5px;
      }
    '';
  };
}
