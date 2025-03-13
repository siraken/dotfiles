#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# バッテリー残量に応じてアイコンを設定
case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON=""
  ;;
[6-8][0-9])
  ICON=""
  ;;
[3-5][0-9])
  ICON=""
  ;;
[1-2][0-9])
  ICON=""
  ;;
*) ICON="" ;;
esac

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color=0xff9d7cd8 \
  label="${PERCENTAGE}%" \
  label.color=0xff9d7cd8 \
  background.color=0xff1a1b26 \
  background.drawing=on
