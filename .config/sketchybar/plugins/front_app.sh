#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

FRONT_APP="$(/usr/bin/lsappinfo info -only name `/usr/bin/lsappinfo front` | cut -d '"' -f4)"

if [[ $FRONT_APP = "" ]]; then
  FRONT_APP="Desktop"
fi

sketchybar --set "$NAME" \
  label="$FRONT_APP" \
  background.color=0xff1a1b26 \
  background.drawing=on
