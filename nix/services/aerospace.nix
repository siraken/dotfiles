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
      "DiffusionBee"
      "balenaEtcher"
      "Alfred Preferences"
      "DaisyDisk"
      "VMware Fusion"
      "HYPERSBI2"
      "Google Drive"
      "Happy Hacking Keyboard Keymap Tool"
      "HHKB Keymap Tool"
    ];

    adobe = [
      "Adobe Photoshop 2023"
      "Adobe Illustrator 2023"
      "Adobe Premiere Pro 2023"
      "Adobe After Effects 2023"
      "Adobe XD"
      "Adobe Lightroom"
    ];

    design = [
      "Pixelmator Pro"
      "Figma"
      "Blender"
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

    # browsers = [
    #   "Google Chrome"
    #   "Firefox"
    #   "Firefox Developer Edition"
    #   "Brave Browser"
    #   "Vivaldi"
    #   "Safari"
    #   "Blisk"
    #   "Microsoft Edge"
    #   "Tor Browser"
    # ];

    development = [
      "TablePlus"
      "Transmit"
      "GitHub Desktop"
      "Sourcetree"
      "Docker Desktop"
      "Sublime Text"
      "WebTorrent"
      # "iTerm2"
      # "Visual Studio"
    ];

    communication = [
      # "zoom.us"
      "Spark"
      "Slack"
      "Discord"
    ];

    streaming = [
      "Spotify"
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
  generateWindowRule = app: {
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

      # Layout configuration (yabai の layout = "bsp" に対応)
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      # Gaps and padding
      # yabai: external_bar = "all:32:0"
      # yabai: top_padding = 12, bottom_padding = 12, left_padding = 12, right_padding = 12
      # yabai: window_gap = 6
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.left = 12;
        outer.bottom = 12;
        outer.top = 44; # 32 (external bar) + 12 (top_padding)
        outer.right = 12;
      };

      # Workspace to monitor mapping
      workspace-to-monitor-force-assignment = {
        "1" = "main";
      };

      # Mode configuration
      mode.main.binding = {
        # Focus windows
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # Move windows
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Resize windows (yabai の split_ratio に相当)
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

        # Balance windows (yabai の auto_balance equivalent)
        alt-shift-b = "balance-sizes";

        # Reload config
        alt-shift-r = "reload-config";

        # Service mode
        alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];
      };

      # Window rules for unmanaged applications
      # これらのアプリはタイリングではなくフローティングになります (yabai の manage=off に相当)
      on-window-detected = map generateWindowRule allUnmanagedApps;
    };
  };
}
