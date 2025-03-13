#!/bin/sh

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
  [6-9][0-9] | 100)
    ICON="󰕾"
    ;;
  [3-5][0-9])
    ICON="󰖀"
    ;;
  [1-9] | [1-2][0-9])
    ICON="󰕿"
    ;;
  *) ICON="󰖁" ;;
  esac

  sketchybar --set "$NAME" \
    icon="$ICON" \
    icon.color=0xfff7768e \
    background.color=0xff1a1b26 \
    background.drawing=on \
    label="$VOLUME%" \
    label.color=0xfff7768e
fi
