{ pkgs, lib, ... }:
let
  unmanagedApps = {
    macOSUtilities = [
      "Finder"
      "Stickies"
      "System Preferences"
      "System Settings"
      "Activity Monitor"
      "Console"
      "Screen Sharing"
      "Preview"
      "Photos"
      "QuickTime Player"
      "Messages"
      "Feedback Assistant"
      "Xcode"
      "Final Cut Pro"
      "Motion"
      "Logic Pro"
      "Disk Utility"
    ];

    iWork = [
      "Pages"
      "Numbers"
      "Keynote"
    ];

    microsoftOffice = [
      "Word"
      "Excel"
      "PowerPoint"
      # "OneNote"
      # "Outlook"
      # "Microsoft Teams"
      "Microsoft Remote Desktop"
    ];

    utilities = [
      "1Password"
      "balenaEtcher"
      "Alfred Preferences"
      "DaisyDisk"
      "VMware Fusion"
      "HYPERSBI2"
      "Google Drive"
      "Happy Hacking Keyboard Keymap Tool"
      "HHKB Keymap Tool"
    ];

    music = [
      "Studio One 5"
      "eqMac"
      "VOICEVOX"
    ];

    video = [
      "DaVinci Resolve"
      "OBS"
      "VTube Studio"
    ];

    development = [
      "TablePlus"
      "Transmit"
      "GitHub Desktop"
      "Sourcetree"
      "Docker Desktop"
      "WebTorrent"
      # "Visual Studio"
    ];

    security = [
      "ESET Endpoint Security"
    ];

    games = [
      "Steam"
      "Riot Client"
      "League of Legends"
      "League Of Legends"
      "Minecraft Launcher"
      "java"
    ];
  };

  # すべてのアプリを1つのリストに結合
  allUnmanagedApps = lib.flatten (lib.attrValues unmanagedApps);

  # AeroSpace on-window-detected ルールを生成
  mkWindowRule = app: {
    "if" = {
      app-name-regex-substring = app;
    };
    run = "layout floating";
  };
in
{
  programs.aerospace = {
    enable = true;

    # launchdで自動起動を管理
    launchd = {
      enable = true;
    };

    settings = {
      # Normalizations
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      # Layout configuration
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      automatically-unhide-macos-hidden-apps = false;
      on-focus-changed = [ ];
      on-focused-monitor-changed = [ ];

      # Gaps and padding
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.left = 12;
        outer.bottom = 12;
        outer.top = [
          { monitor.main = 12; }
          44 # 32 (external bar) + 12 (top_padding)
        ];
        outer.right = 12;
      };

      # Mode configuration
      mode.main.binding = {
        # Focus windows
        alt-shift-h = "focus --boundaries all-monitors-outer-frame left";
        alt-shift-j = "focus --boundaries all-monitors-outer-frame down";
        alt-shift-k = "focus --boundaries all-monitors-outer-frame up";
        alt-shift-l = "focus --boundaries all-monitors-outer-frame right";

        # Move windows
        ctrl-cmd-h = "move --boundaries all-monitors-outer-frame left";
        ctrl-cmd-j = "move --boundaries all-monitors-outer-frame down";
        ctrl-cmd-k = "move --boundaries all-monitors-outer-frame up";
        ctrl-cmd-l = "move --boundaries all-monitors-outer-frame right";

        # Resize windows
        alt-ctrl-h = "resize smart -50";
        alt-ctrl-j = "resize smart -50";
        alt-ctrl-k = "resize smart +50";
        alt-ctrl-l = "resize smart +50";

        # Workspace switching
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        # Move windows to workspaces
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        # Toggle layout modes
        alt-shift-space = "layout tiles horizontal vertical";
        alt-f = "fullscreen";
        alt-t = "layout floating tiling";

        # Balance windows
        alt-shift-b = "balance-sizes";

        # Reload config
        alt-shift-r = "reload-config";

        # Service mode
        alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];
      };

      # Window detection rules
      # - unmanagedApps: フローティングレイアウトを適用
      # - Ghostty: タイリングレイアウトを適用
      on-window-detected = (map mkWindowRule allUnmanagedApps) ++ [
        {
          "if" = {
            app-id = "com.mitchellh.ghostty";
          };
          run = [ "layout tiling" ];
        }
      ];

      workspace-to-monitor-force-assignment = {
        "1" = "main";
        "2" = "main";
        "3" = "main";
        "4" = "main";
        "5" = "main";
        "6" = [
          "secondary"
          "main"
        ];
        "7" = [
          "secondary"
          "main"
        ];
        "8" = [
          "secondary"
          "main"
        ];
        "9" = [
          "secondary"
          "main"
        ];
      };

      after-startup-command = [
        "exec-and-forget sketchybar"
      ];

      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];
    };
  };
}
