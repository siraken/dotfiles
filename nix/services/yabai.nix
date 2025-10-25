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

  # アプリ名をエスケープする関数
  escapeAppName = name: builtins.replaceStrings [ " " ] [ "\\ " ] name;

  # yabaiルールを生成する関数
  generateRule = app: "yabai -m rule --add app=${escapeAppName app} manage=off";
in
{
  services.yabai = {
    enable = true;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "on";
      window_topmost = "off";
      window_shadow = "on";
      window_animation_duration = 0.0;
      window_animation_frame_rate = 120;
      window_opacity_duration = 0.0;
      active_window_opacity = 1.0;
      normal_window_opacity = 0.50;
      window_opacity = "off";
      insert_feedback_color = "0xffd75f5f";
      active_window_border_color = "0xff775759";
      normal_window_border_color = "0xff555555";
      window_border_width = 4;
      window_border_radius = 12;
      window_border_blur = "off";
      window_border_hidpi = "on";
      window_border = "off";
      split_ratio = 0.50;
      split_type = "auto";
      auto_balance = "off";
      external_bar = "all:32:0";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      window_gap = 6;
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = lib.concatMapStringsSep "\n" generateRule allUnmanagedApps;
  };
}
