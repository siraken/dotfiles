{ pkgs, ... }:
{
  services.skhd = {
    enable = true;
    # Modifiers:
    #  - fn: function key
    #  - cmd: command key
    #  - alt: option key
    #  - ctrl: control key
    #  - shift: shift key
    #  - hyper: cmd + shift + alt + ctrl
    #  - meh: shift + alt + ctrl
    skhdConfig = ''
      # focus window
      shift + alt - h : yabai -m window --focus west || yabai -m display --focus west
      shift + alt - j : yabai -m window --focus south || yabai -m display --focus south
      shift + alt - k : yabai -m window --focus north || yabai -m display --focus north
      shift + alt - l : yabai -m window --focus east || yabai -m display --focus east

      # move window
      ctrl + cmd - h : yabai -m window --warp west || (yabai -m window --display west; yabai -m display --focus west)
      ctrl + cmd - j : yabai -m window --warp south || (yabai -m window --display south; yabai -m display --focus south)
      ctrl + cmd - k : yabai -m window --warp north || (yabai -m window --display north; yabai -m display --focus north)
      ctrl + cmd - l : yabai -m window --warp east || (yabai -m window --display east; yabai -m display --focus east)

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # invert tree x-axis
      alt - x : yabai -m space --mirror x-axis

      # invert tree y-axis
      alt - y : yabai -m space --mirror y-axis

      # toggle window fullscreen zoom
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and restore position
      # alt - t : yabai -m window --toggle float && /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null || true
      alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

      # toggle picture-in-picture
      alt - p : yabai -m window --toggle border --toggle pip
    '';
  };
}
