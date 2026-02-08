{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    customPaneNavigationAndResize = false;
    escapeTime = 500;
    historyLimit = 2000;
    keyMode = "vi";
    mouse = false;
    prefix = null;
    resizeAmount = 5;
    reverseSplit = false;
    shortcut = "b";
    terminal = "screen-256color";

    # Tokyo Night theme plugin
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style none
          set -g @tokyo-night-tmux_pane_id_style hide
          set -g @tokyo-night-tmux_show_music 0
          set -g @tokyo-night-tmux_show_netspeed 0
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative
          set -g @tokyo-night-tmux_show_git 1
          set -g @tokyo-night-tmux_show_datetime 0
        '';
      }
    ];

    # Custom configuration
    extraConfig = ''
      set-option -g default-shell "${pkgs.bash}/bin/bash"
      set -g default-command "${pkgs.bash}/bin/bash"

      # Display settings
      set -g display-time 2000
      set -g repeat-time 0

      # Pane navigation
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # Pane resizing
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5

      # Kill all other panes
      bind -r e kill-pane -a

      # Window swapping
      bind -n C-S-Left swap-window -t -1 \; previous-window
      bind -n C-S-Right swap-window -t +1 \; next-window

      # Window titles
      set -g set-titles on
      set -g set-titles-string "#T"

      # Status bar
      set -g status-interval 1
      set -g status-justify 'left'
    '';
  };
}
