#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

FRONT_APP="$(/usr/bin/lsappinfo info -only name `/usr/bin/lsappinfo front` | cut -d '"' -f4)"

if [[ $FRONT_APP = "" ]]; then
  FRONT_APP="Desktop"
fi

ICON="󰈙"
ICON_DRAWING=on
ICON_COLOR=0xffffffff

if [[ "$FRONT_APP" =~ ^(Google Chrome|Chromium|Brave|Vivaldi)$ ]]; then
  ICON=""
elif [[ "$FRONT_APP" =~ ^(Microsoft Edge|Edge)$ ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Safari" ]]; then
  ICON=""
elif [[ "$FRONT_APP" =~ ^(Code|Cursor)$ ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "GitHub Desktop" ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Finder" ]]; then
  ICON="󰀶"
elif [[ "$FRONT_APP" = "Slack" ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Discord" ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Spotify" ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Music" ]]; then
  ICON="󰝚"
elif [[ "$FRONT_APP" =~ ^(IntelliJ|RubyMine|PhpStorm|WebStorm|GoLand)$ ]]; then
  ICON=""
elif [[ "$FRONT_APP" = "Xcode" ]]; then
  ICON=""
elif [[ "$FRONT_APP" =~ ^(Terminal|Kitty|Ghostty|Alacritty|WezTerm)$ ]]; then
  ICON=""
else
  ICON_DRAWING=off
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  icon.drawing="$ICON_DRAWING" \
  label="$FRONT_APP" \
  background.color=0xff1a1b26 \
  background.drawing=on
