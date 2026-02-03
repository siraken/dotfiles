{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    # programs (cross-platform)
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/direnv
    # ../../programs/fish # disabled due to fisher hash mismatch
    ../../programs/fzf
    ../../programs/ghostty
    ../../programs/git
    ../../programs/helix
    ../../programs/kitty
    ../../programs/lazydocker
    ../../programs/lazygit
    ../../programs/mise
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home = {
    stateVersion = "25.11";
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      # nixos-vm specific
      pkgs.playerctl
      pkgs.neofetch
    ];

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = false; # fish disabled
      enableZshIntegration = true;
      enableShellIntegration = true;
    };
  };

  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      theme = "gruvbox-dark";
      terminal = "${pkgs.ghostty}/bin/ghostty";
    };
  };

  # Polybar
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = "polybar main &";
    settings = {
      "bar/main" = {
        width = "100%";
        height = "28pt";
        radius = 0;
        background = "#00000000";
        foreground = "#cdd6f4";
        padding-left = 1;
        padding-right = 1;
        module-margin = 1;
        font-0 = "JetBrainsMono Nerd Font:size=10;2";
        font-1 = "JetBrainsMono Nerd Font:size=12;2";
        font-2 = "Noto Sans CJK JP:size=10;2";
        modules-left = "i3";
        modules-center = "";
        modules-right = "pulseaudio network date";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        enable-ipc = true;
        tray-position = "right";
        tray-padding = 4;
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        show-urgent = true;
        strip-wsnumbers = true;
        index-sort = true;
        format = "<label-state> <label-mode>";

        label-mode = "%mode%";
        label-mode-padding = 2;
        label-mode-background = "#89b4fa";
        label-mode-foreground = "#1e1e2e";

        label-focused = "%index%";
        label-focused-background = "#89b4fa";
        label-focused-foreground = "#1e1e2e";
        label-focused-padding = 2;

        label-unfocused = "%index%";
        label-unfocused-background = "#313244";
        label-unfocused-foreground = "#cdd6f4";
        label-unfocused-padding = 2;

        label-visible = "%index%";
        label-visible-background = "#45475a";
        label-visible-foreground = "#cdd6f4";
        label-visible-padding = 2;

        label-urgent = "%index%";
        label-urgent-background = "#f38ba8";
        label-urgent-foreground = "#1e1e2e";
        label-urgent-padding = 2;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%a %b %d";
        time = "%H:%M";
        format = "<label>";
        format-background = "#313244";
        format-foreground = "#cdd6f4";
        format-padding = 2;
        label = "  %date%  %time%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = true;
        interval = 5;
        format-volume = "<ramp-volume> <label-volume>";
        format-volume-background = "#313244";
        format-volume-padding = 2;
        label-volume = "%percentage%%";
        label-muted = "  muted";
        label-muted-background = "#313244";
        label-muted-foreground = "#6c7086";
        label-muted-padding = 2;
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        click-right = "pavucontrol";
      };

      "module/network" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 3;
        format-connected = "<label-connected>";
        format-connected-background = "#313244";
        format-connected-padding = 2;
        format-disconnected = "<label-disconnected>";
        format-disconnected-background = "#313244";
        format-disconnected-padding = 2;
        label-connected = "  %local_ip%";
        label-disconnected = "  disconnected";
        label-disconnected-foreground = "#6c7086";
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };
    };
  };

  # i3 config
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4"; # Super key
      terminal = "ghostty";
      menu = "rofi -show drun";

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 10.0;
      };

      gaps = {
        inner = 8;
        outer = 4;
      };

      # Disable i3bar, use polybar instead
      bars = [ ];

      keybindings =
        let
          mod = "Mod4";
        in
        {
          "${mod}+Return" = "exec ghostty";
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
        {
          command = "xrandr --output Virtual-1 --mode 1920x1080";
          notification = false;
        }
        {
          command = "picom -b";
          notification = false;
        }
        {
          command = "dunst";
          notification = false;
        }
        {
          command = "feh --bg-fill ~/.wallpaper.jpg || feh --bg-scale /run/current-system/sw/share/backgrounds/gnome/adwaita-l.jpg";
          notification = false;
        }
        {
          command = "fcitx5 -d";
          notification = false;
        }
        {
          command = "systemctl --user restart polybar";
          notification = false;
          always = true;
        }
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
