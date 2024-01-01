{ config, inputs, pkgs, ... }: {
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

      bind-key -r f run-shell "tmux neww tmux-sessionizer"
      bind-key -r m run-shell "tmux switch-client -t main"

      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
    '';
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "tmux-sessionizer";
      runtimeInputs = [ pkgs.tmux pkgs.fd pkgs.ghq ];
      text = ''
        ${builtins.readFile ./tmux-sessionizer.sh}
      '';
    })
  ];
}
