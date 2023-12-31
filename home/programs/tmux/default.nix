{ config, inputs, pkgs, ... }:
let
  proj_dirs =
    "~/repos/github.com/callumio ~/repos/projects.cs.nott.ac.uk/psycl6";
in {
  programs.tmux = {
    enable = true;
    shortcut = "x";
    baseIndex = 0;
    escapeTime = 0;
    clock24 = true;
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = onedark-theme;
        extraConfig = "\n";
      }
    ];

    extraConfig = ''
      set-option -g status-position top
      set-option -g default-terminal "tmux-256color"
      set-option -sa terminal-features ',xterm-256color:RGB'
      set-window-option -g mode-keys vi

      bind / split-window -h -c "#{pane_current_path}"
      bind \\ split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind-key -r f run-shell "tmux neww tmux-sessionizer ${proj_dirs}"

      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
    '';
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "tmux-sessionizer";
      runtimeInputs = [ pkgs.tmux ];
      text = ''
        if [[ $# -eq 0 ]]; then
          exit
        else
          # shellcheck disable=SC2068
          selected=$(find $@ -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
          exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
          tmux new-session -s "$selected_name" -c "$selected"
          exit 0
        fi

        if ! tmux has-session -t="$selected_name" 2>/dev/null; then
          tmux new-session -ds "$selected_name" -c "$selected"
        fi

        tmux switch-client -t "$selected_name"
      '';
    })
  ];
}
