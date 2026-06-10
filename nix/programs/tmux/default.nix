{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 0;
    clock24 = true;
    customPaneNavigationAndResize = false;
    escapeTime = 500;
    focusEvents = false;
    historyLimit = 2000;
    keyMode = "vi";
    mouse = false;
    newSession = false;
    prefix = null;
    resizeAmount = 5;
    reverseSplit = false;
    shell = "${pkgs.bash}/bin/bash";
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

    # Custom config lives in a repo file sourced directly, so it is editable in
    # place (reload with `tmux source-file` — no rebuild). The structured
    # options above, the shell, and plugins stay in Nix because they resolve
    # store paths. See #70.
    extraConfig = ''
      source-file ${config.home.homeDirectory}/dotfiles/config/tmux/tmux.conf
    '';
  };
}
