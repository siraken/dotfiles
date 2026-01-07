{ pkgs, lib, ... }:
let
  # Colors (Tokyo Night theme)
  colors = {
    transparent = "0x00000000";
    background = "0xff1a1b26";
    white = "0xffffffff";
    purple = "0xff9d7cd8";
    pink = "0xfff7768e";
    orange = "0xffff9e64";
    green = "0xff9ece6a";
    spotifyGreen = "0xff1ed760";
    appleMusicPink = "0xffff4e6b";
    workspaceActive = "0x44ffffff";
  };

  # Create plugin scripts using writeShellScript
  aerospacePlugin = pkgs.writeShellScript "aerospace.sh" (builtins.readFile ./plugins/aerospace.sh);
  clockPlugin = pkgs.writeShellScript "clock.sh" (builtins.readFile ./plugins/clock.sh);
  batteryPlugin = pkgs.writeShellScript "battery.sh" (builtins.readFile ./plugins/battery.sh);
  volumePlugin = pkgs.writeShellScript "volume.sh" (builtins.readFile ./plugins/volume.sh);
  frontAppPlugin = pkgs.writeShellScript "front_app.sh" (builtins.readFile ./plugins/front_app.sh);
  spotifyPlugin = pkgs.writeShellScript "spotify.sh" (builtins.readFile ./plugins/spotify.sh);
  spotifyClickPlugin = pkgs.writeShellScript "spotify_click.sh" (
    builtins.readFile ./plugins/spotify_click.sh
  );
  appleMusicPlugin = pkgs.writeShellScript "apple_music.sh" (
    builtins.readFile ./plugins/apple_music.sh
  );
  appleMusicClickPlugin = pkgs.writeShellScript "apple_music_click.sh" (
    builtins.readFile ./plugins/apple_music_click.sh
  );
in
{
  services.sketchybar = {
    enable = true;
    config = ''
      sketchybar --bar \
        position=top \
        height=38 \
        blur_radius=0 \
        color=${colors.transparent}

      default=(
        icon.font="Hack Nerd Font:regular:17.0"
        label.font="Hack Nerd Font:regular:12.0"
        icon.padding_left=8
        icon.padding_right=0
        label.padding_left=8
        label.padding_right=8
        background.height=30
        background.corner_radius=6
      )
      sketchybar --default "''${default[@]}"

      ##### Left Items #####
      sketchybar \
        --add item front_app left \
        --set front_app script="${frontAppPlugin}" \
        --subscribe front_app front_app_switched

      sketchybar --add event aerospace_workspace_change
      for sid in $(aerospace list-workspaces --all); do
        sketchybar --add item space.$sid left \
          --subscribe space.$sid aerospace_workspace_change \
          --set space.$sid \
            background.color=${colors.workspaceActive} \
            background.corner_radius=5 \
            background.height=20 \
            background.drawing=off \
            label="$sid" \
            click_script="aerospace workspace $sid" \
            script="${aerospacePlugin} $sid"
      done

      ##### Right Items #####
      sketchybar \
        --add item clock right \
        --set clock update_freq=10 padding_left=5 script="${clockPlugin}" \
        --add item volume right \
        --set volume padding_left=5 script="${volumePlugin}" \
        --subscribe volume volume_change \
        --add item battery right \
        --set battery update_freq=120 padding_left=5 script="${batteryPlugin}" \
        --subscribe battery system_woke power_source_change \
        --add item spotify right \
        --set spotify update_freq=1 padding_left=5 script="${spotifyPlugin}" click_script="${spotifyClickPlugin}" \
        --add item apple_music right \
        --set apple_music update_freq=1 padding_left=5 script="${appleMusicPlugin}" click_script="${appleMusicClickPlugin}"

      sketchybar --update
    '';
  };
}
