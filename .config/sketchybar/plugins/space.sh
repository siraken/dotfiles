#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
    background.color=0xff414868 \
    icon.color=0xff7aa2f7
else
  sketchybar --set "$NAME" \
    background.color=0xff1a1b26 \
    icon.color=0xffc0caf5
fi
