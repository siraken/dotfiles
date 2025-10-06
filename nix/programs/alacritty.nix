{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      # General settings
      live_config_reload = true;

      # Environment variables
      env = {
        GITHUB_USERNAME = "siraken";
        TERM = "xterm-256color";
      };

      # Terminal settings
      terminal = {
        shell = {
          program = "/opt/homebrew/bin/bash";
        };
      };

      # Cursor settings
      cursor = {
        style = {
          blinking = "Off";
          shape = "Block";
        };
      };

      # Mouse settings
      mouse = {
        hide_when_typing = false;
      };

      # Scrolling settings
      scrolling = {
        history = 10000;
      };

      # Keyboard settings
      keyboard = {
        bindings = [ ];
      };

      # Debug settings
      debug = {
        render_timer = false;
        persistent_logging = false;
        log_level = "Warn";
        renderer = "None";
        print_events = false;
        highlight_damage = false;
        prefer_egl = false;
      };

      # Window settings
      window = {
        dynamic_padding = true;
        dynamic_title = true;
        opacity = 0.5;
        startup_mode = "Windowed";
        title = "Alacritty";
        blur = true;
        decorations = "Buttonless";

        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };

        dimensions = {
          columns = 150;
          lines = 40;
        };
      };

      # Font settings
      font = {
        builtin_box_drawing = true;
        size = 16.0;

        normal = {
          family = "Hack Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "Hack Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "Hack Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "Hack Nerd Font";
          style = "Bold Italic";
        };

        glyph_offset = {
          x = 0;
          y = 0;
        };

        offset = {
          x = 1;
          y = 0;
        };
      };

      # Colors (Tokyo Night)
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#a9b1d6";
        };

        normal = {
          black = "#32344a";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#ad8ee6";
          cyan = "#449dab";
          white = "#787c99";
        };

        bright = {
          black = "#444b6a";
          red = "#ff7a93";
          green = "#b9f27c";
          yellow = "#ff9e64";
          blue = "#7da6ff";
          magenta = "#bb9af7";
          cyan = "#0db9d7";
          white = "#acb0d0";
        };
      };
    };
  };
}
