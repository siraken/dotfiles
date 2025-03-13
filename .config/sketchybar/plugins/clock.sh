#!/bin/sh

sketchybar --set "$NAME" \
  icon.color=0xff9ece6a \
  background.color=0xff1a1b26 \
  label="$(date '+%a %b %d %H:%M')"
