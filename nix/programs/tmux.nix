{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    enableMouse = true;
    enableSensible = true;
    enableVim = true;

    # Custom configuration
    extraConfig = ''
      set -s escape-time 50
      set-option -g default-shell "/opt/homebrew/bin/bash"
      set -g default-command "/opt/homebrew/bin/bash"

      # Terminal overrides
      set -ag terminal-overrides ',xterm-256color:RGB'

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

      # Clock mode color
      setw -g clock-mode-colour colour64

      # Window titles
      set -g set-titles on
      set -g set-titles-string "#T"

      # Status bar
      set -g status-interval 1
      set -g status-justify 'left'
      set -g status-left '#{actual_song}'
      set -g status-right '#{actual_song}'
      set -g status-bg default

      # Import macOS config
      # if-shell 'uname -s | grep -q Darwin' 'source $HOME/.config/tmux/tmux.darwin.conf'
    '';

    # tmuxOptions = {
    #   # Terminal settings
    #   terminal = "tmux-256color";
    #   escapeTime = 1;
    #   historyLimit = 64096;

    #   # Mouse support

    #   # Prefix key
    #   prefix = "C-t";
    # };

    # Plugins
    # plugins = with pkgs.tmuxPlugins; [
    #   {
    #     plugin = tpm;
    #     extraConfig = "";
    #   }
    #   {
    #     plugin = logging;
    #     extraConfig = "";
    #   }
    #   {
    #     plugin = pain-control;
    #     extraConfig = "";
    #   }
    #   {
    #     plugin = prefix-highlight;
    #     extraConfig = "";
    #   }
    #   # Note: tmux-spotify-tui and tmux-keyboard-layout may need to be added manually
    #   # as they might not be available in nixpkgs
    # ];
  };
}
