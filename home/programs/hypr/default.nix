{ config, inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    xwayland.enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1

      general {
          gaps_in = 0
          gaps_out = 0
          border_size = 1
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle
      }

      decoration {
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 1, default, popin
          animation = fade, 1, 7, default
          animation = workspaces, 1, 1, default, fade
      }

      dwindle {
          pseudotile = yes
          preserve_split = yes
          no_gaps_when_only = 1
      }

      master {
          new_is_master = true
          no_gaps_when_only = 1
      }

      gestures {
          workspace_swipe = false
      }

      misc {
        enable_swallow = true
        swallow_regex = Alacritty
      }

      input {
          kb_layout = gb
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
              scroll_factor = 0.3
          }

          sensitivity = 0.5
          accel_profile = flat
          scroll_method = 2fg
      }

      misc {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;  
      }

      $mainMod = SUPER

      # Utility Binds
      bind = $mainMod, q, killactive, 
      bind = $mainMod SHIFT, q, exit, 
      bind = $mainMod, F, fullscreen, 
      bind = $mainMod SHIFT, f, togglefloating
      bind = $mainMod, d, exec, rofi -show drun
      bind = $mainMod, w, exec, rofi -show window
      bind = $mainMod, p, exec, rofi-rbw --no-folder
      bind = $mainMod, s, togglesplit, # dwindle
      bind = $mainMode SHIFT, r, exec, hyprctl reload

      # Program Binds
      bind = $mainMod, return, exec, alacritty -e tmux new -A -s main
      bind = $mainMod SHIFT, return, exec, [float; pin] alacritty -e tmux new -A -s main
      bind = $mainMod SHIFT, b, exec, firefox
      bind = $mainMod, b, workspace, name:web
      bind = $mainMod, n, workspace, name:chat
      bind = $mainMod, m, workspace, name:media

      # Traverse Windows
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      bind = $mainMod SHIFT, h, movewindow, l
      bind = $mainMod SHIFT, l, movewindow, r
      bind = $mainMod SHIFT, k, movewindow, u
      bind = $mainMod SHIFT, j, movewindow, d

      # Custom Workspaces

      workspace = name:web, on-created-empty: firefox
      workspace = name:chat, on-created-empty: webcord
      workspace = name:media, on-created-empty: spotify


      # Traverse Workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Resize
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # XF86 Binds
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindle = , XF86AudioMute , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      bindle = , XF86AudioMicMute , exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      bindle = , XF86AudioPlay , exec, playerctl play-pause
      bindle = , XF86AudioPause , exec, playerctl play-pause
      bindle = , XF86AudioNext , exec, playerctl next
      bindle = , XF86AudioPrev , exec, playerctl previous

      bindle = , XF86MonBrightnessUp, exec, brightnessctl -c backlight set +5%
      bindle = , XF86MonBrightnessDown, exec, brightnessctl -c backlight set 5%-

      # Print Screen
      bind = SHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy
      bind = , Print, exec, grim - | wl-copy

      exec-once = webcord -m
      exec-once = nm-applet --indicator
      exec-once = blueman-tray
      exec-once = mullvad-gui
      exec = pkill wpaperd & sleep 0.5 && wpaperd
      exec = pkill waybar & sleep 0.5 && waybar
      exec = pkill mako & sleep 0.5 && mako
    '';

  };
}
