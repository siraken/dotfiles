{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../programs/git.nix
  ];

  home = {
    stateVersion = "25.11";

    packages = with pkgs; [
      # Basic tools
      eza
      bat
      ripgrep
      fd
      fzf
      htop
      neofetch
      tmux
      lazygit
    ];
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    kitty = {
      enable = true;
      settings = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 12;
        background_opacity = "0.9";
        confirm_os_window_close = 0;
      };
    };

    rofi = {
      enable = true;
      theme = "gruvbox-dark";
      terminal = "${pkgs.kitty}/bin/kitty";
    };

    starship.enable = true;
    zoxide.enable = true;
    direnv.enable = true;
  };

  # i3 config
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4"; # Super key
      terminal = "kitty";
      menu = "rofi -show drun";

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 10.0;
      };

      gaps = {
        inner = 8;
        outer = 4;
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 10.0;
          };
          colors = {
            background = "#1e1e2e";
            statusline = "#cdd6f4";
            separator = "#45475a";
            focusedWorkspace = {
              border = "#89b4fa";
              background = "#89b4fa";
              text = "#1e1e2e";
            };
            inactiveWorkspace = {
              border = "#1e1e2e";
              background = "#1e1e2e";
              text = "#6c7086";
            };
          };
        }
      ];

      keybindings = let
        mod = "Mod4";
      in {
        "${mod}+Return" = "exec kitty";
        "${mod}+d" = "exec rofi -show drun";
        "${mod}+q" = "kill";
        "${mod}+Shift+e" = "exec i3-msg exit";
        "${mod}+Shift+r" = "restart";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Split
        "${mod}+b" = "split h";
        "${mod}+v" = "split v";

        # Layout
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        # Workspaces
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";

        # Move to workspace
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";

        # Screenshot
        "Print" = "exec maim -s | xclip -selection clipboard -t image/png";
      };

      window = {
        border = 2;
        titlebar = false;
      };

      colors = {
        focused = {
          border = "#89b4fa";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#89b4fa";
          childBorder = "#89b4fa";
        };
        unfocused = {
          border = "#45475a";
          background = "#1e1e2e";
          text = "#6c7086";
          indicator = "#45475a";
          childBorder = "#45475a";
        };
      };

      startup = [
        { command = "picom -b"; notification = false; }
        { command = "dunst"; notification = false; }
        { command = "feh --bg-fill ~/.wallpaper.jpg || feh --bg-scale /run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg"; notification = false; }
        { command = "fcitx5 -d"; notification = false; }
      ];
    };
  };

  # Dunst notification
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Noto Sans CJK JP 11";
        frame_color = "#89b4fa";
        separator_color = "frame";
        corner_radius = 8;
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
      };
    };
  };

  # Picom compositor
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
    settings = {
      corner-radius = 8;
    };
  };
}
