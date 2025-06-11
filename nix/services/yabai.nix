{ pkgs, ... }:
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
    extraConfig = ''
      # macOS Utilities
      yabai -m rule --add app=Finder manage=off
      yabai -m rule --add app=Stickies manage=off
      yabai -m rule --add app=System\ Preferences manage=off
      yabai -m rule --add app=System\ Settings manage=off
      yabai -m rule --add app=Activity\ Monitor manage=off
      yabai -m rule --add app=Console manage=off
      yabai -m rule --add app=Screen\ Sharing manage=off
      yabai -m rule --add app=Preview manage=off
      yabai -m rule --add app=Photos manage=off
      yabai -m rule --add app=QuickTime\ Player manage=off
      yabai -m rule --add app=Messages manage=off
      yabai -m rule --add app=Feedback\ Assistant manage=off
      yabai -m rule --add app=Xcode manage=off
      yabai -m rule --add app=Final\ Cut\ Pro manage=off
      yabai -m rule --add app=Motion manage=off
      yabai -m rule --add app=Logic\ Pro manage=off
      yabai -m rule --add app=Disk\ Utility manage=off

      # macOS iWork
      yabai -m rule --add app=Pages manage=off
      yabai -m rule --add app=Numbers manage=off
      yabai -m rule --add app=Keynote manage=off

      # Microsoft Office
      yabai -m rule --add app=Word manage=off
      yabai -m rule --add app=Excel manage=off
      yabai -m rule --add app=PowerPoint manage=off
      # yabai -m rule --add app=OneNote manage=off
      # yabai -m rule --add app=Outlook manage=off
      # yabai -m rule --add app=Microsoft\ Teams manage=off
      yabai -m rule --add app=Microsoft\ Remote\ Desktop manage=off

      # Utilities
      yabai -m rule --add app=1Password manage=off
      yabai -m rule --add app=DiffusionBee manage=off
      yabai -m rule --add app=balenaEtcher manage=off
      yabai -m rule --add app=Alfred\ Preferences manage=off
      yabai -m rule --add app=DaisyDisk manage=off
      yabai -m rule --add app=VMware\ Fusion manage=off
      yabai -m rule --add app=HYPERSBI2 manage=off

      # Adobe
      yabai -m rule --add app=Adobe\ Photoshop\ 2023 manage=off
      yabai -m rule --add app=Adobe\ Illustrator\ 2023 manage=off
      yabai -m rule --add app=Adobe\ Premiere\ Pro\ 2023 manage=off
      yabai -m rule --add app=Adobe\ After\ Effects\ 2023 manage=off
      yabai -m rule --add app=Adobe\ XD manage=off
      yabai -m rule --add app=Adobe\ Lightroom manage=off

      # Design
      yabai -m rule --add app=Pixelmator\ Pro manage=off
      yabai -m rule --add app=Figma manage=off
      yabai -m rule --add app=Blender manage=off

      # Music
      yabai -m rule --add app=Studio\ One\ 5 manage=off
      yabai -m rule --add app=eqMac manage=off
      yabai -m rule --add app=VOICEVOX manage=off

      # Video
      yabai -m rule --add app=DaVinci\ Resolve manage=off
      yabai -m rule --add app=OBS manage=off
      yabai -m rule --add app=VTube\ Studio manage=off

      # Browsers
      # yabai -m rule --add app=Google\ Chrome manage=off
      # yabai -m rule --add app=Firefox manage=off
      # yabai -m rule --add app=Firefox\ Developer\ Edition manage=off
      # yabai -m rule --add app=Brave\ Browser manage=off
      # yabai -m rule --add app=Vivaldi manage=off
      # yabai -m rule --add app=Safari manage=off
      # yabai -m rule --add app=Blisk manage=off
      # yabai -m rule --add app=Microsoft\ Edge manage=off
      # yabai -m rule --add app=Tor\ Browser manage=off

      # Development
      yabai -m rule --add app=TablePlus manage=off
      yabai -m rule --add app=Transmit manage=off
      yabai -m rule --add app=GitHub\ Desktop manage=off
      yabai -m rule --add app=Sourcetree manage=off
      yabai -m rule --add app=Docker\ Desktop manage=off
      yabai -m rule --add app=Sublime\ Text manage=off
      yabai -m rule --add app=WebTorrent manage=off
      # yabai -m rule --add app=iTerm2 manage=off
      # yabai -m rule --add app=Visual\ Studio manage=off

      # Communication
      # yabai -m rule --add app=zoom.us manage=off
      yabai -m rule --add app=Spark manage=off
      yabai -m rule --add app=Slack manage=off
      yabai -m rule --add app=Discord manage=off

      # Streaming
      yabai -m rule --add app=Spotify manage=off

      # Security
      yabai -m rule --add app=ESET\ Endpoint\ Security manage=off

      # Games
      yabai -m rule --add app=Steam manage=off
      yabai -m rule --add app=Riot\ Client manage=off
      yabai -m rule --add app=League\ of\ Legends manage=off
      yabai -m rule --add app=League\ Of\ Legends manage=off
    '';
  };
}
