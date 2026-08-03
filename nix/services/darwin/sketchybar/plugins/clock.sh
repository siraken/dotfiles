# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

sketchybar --set "$NAME" \
  icon=󰃰 \
  icon.color="$COLOR_ORANGE" \
  label="$(date '+%a %b %d %H:%M')" \
  label.color="$COLOR_ORANGE" \
  background.color="$COLOR_BG" \
  background.drawing=on
