#!/bin/sh

PLUGIN_DIR="$CONFIG_DIR/plugins"

sketchybar --bar \
  position=top \
  height=38 \
  blur_radius=0 \
  color=0x00000000

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
sketchybar --default "${default[@]}"

##### Left Items #####
sketchybar \
--add item front_app left \
--set front_app script="$PLUGIN_DIR/front_app.sh" \
--subscribe front_app front_app_switched

sketchybar --add event aerospace_workspace_change
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
      --subscribe space.$sid aerospace_workspace_change \
      --set space.$sid \
      background.color=0x44ffffff \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      label="$sid" \
      click_script="aerospace workspace $sid" \
      script="$PLUGIN_DIR/aerospace.sh $sid"
done

##### Right Items #####
sketchybar \
--add item clock right \
--set clock update_freq=10 padding_left=5 script="$PLUGIN_DIR/clock.sh" \
--add item volume right \
--set volume padding_left=5 script="$PLUGIN_DIR/volume.sh" \
--subscribe volume volume_change \
--add item battery right \
--set battery update_freq=120 padding_left=5 script="$PLUGIN_DIR/battery.sh" \
--subscribe battery system_woke power_source_change \
--add item spotify right \
--set spotify update_freq=1 padding_left=5 script="$PLUGIN_DIR/spotify.sh" click_script="$PLUGIN_DIR/spotify_click.sh" \
--add item apple_music right \
--set apple_music update_freq=1 padding_left=5 script="$PLUGIN_DIR/apple_music.sh " click_script="$PLUGIN_DIR/apple_music_click.sh" \

sketchybar --update
