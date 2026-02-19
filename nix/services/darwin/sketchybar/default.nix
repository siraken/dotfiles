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
    workspaceActive = "0xff9d7cd8";
  };

  # Binaries
  aerospace = "${pkgs.aerospace}/bin/aerospace";

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

      # AeroSpace workspaces
      sketchybar --add event aerospace_workspace_change
      SPACE_SIDS=()
      for sid in $(${aerospace} list-workspaces --all); do
        sketchybar --add item space.$sid left \
          --subscribe space.$sid aerospace_workspace_change \
          --set space.$sid \
            background.color=${colors.workspaceActive} \
            background.corner_radius=5 \
            background.height=22 \
            background.drawing=off \
            icon.drawing=off \
            label="$sid" \
            label.font="Hack Nerd Font:bold:12.0" \
            label.padding_left=10 \
            label.padding_right=10 \
            padding_left=3 \
            padding_right=3 \
            click_script="${aerospace} workspace $sid" \
            script="${aerospacePlugin} $sid"
        SPACE_SIDS+=("space.$sid")
      done
      sketchybar --add bracket spaces "''${SPACE_SIDS[@]}" \
        --set spaces \
          background.color=${colors.background} \
          background.corner_radius=6 \
          background.height=30 \
          background.drawing=on

      # Spacer between workspaces and front app
      sketchybar --add item spacer.left left \
        --set spacer.left \
          label.drawing=off \
          icon.drawing=off \
          background.drawing=off \
          padding_left=6 \
          padding_right=0 \
          width=6

      # Front app
      sketchybar \
        --add item front_app left \
        --set front_app script="${frontAppPlugin}" \
        --subscribe front_app front_app_switched

      ##### Right Items #####
      # Note: right items are rendered right-to-left (first added = rightmost)
      sketchybar \
        --add item clock right \
        --set clock update_freq=10 script="${clockPlugin}"

      sketchybar --add item spacer.r1 right \
        --set spacer.r1 label.drawing=off icon.drawing=off background.drawing=off width=6

      sketchybar \
        --add item volume right \
        --set volume script="${volumePlugin}" \
        --subscribe volume volume_change

      sketchybar --add item spacer.r2 right \
        --set spacer.r2 label.drawing=off icon.drawing=off background.drawing=off width=6

      sketchybar \
        --add item battery right \
        --set battery update_freq=120 script="${batteryPlugin}" \
        --subscribe battery system_woke power_source_change

      sketchybar --add item spacer.r3 right \
        --set spacer.r3 label.drawing=off icon.drawing=off background.drawing=off width=6

      sketchybar \
        --add item spotify right \
        --set spotify update_freq=1 script="${spotifyPlugin}" click_script="${spotifyClickPlugin}"

      sketchybar --add item spacer.r4 right \
        --set spacer.r4 label.drawing=off icon.drawing=off background.drawing=off width=6

      sketchybar \
        --add item apple_music right \
        --set apple_music update_freq=1 script="${appleMusicPlugin}" click_script="${appleMusicClickPlugin}"

      sketchybar --update
    '';
  };
}
