# メモリ使用率を表示する。
# memory_pressure は空き割合を返すので使用率に直す（実測 9ms と軽い）。
FREE="$(memory_pressure 2>/dev/null | awk -F': ' '/free percentage/ { gsub(/[^0-9]/, "", $2); print $2; exit }')"
case "$FREE" in
'' | *[!0-9]*) exit 0 ;;
esac

USED=$((100 - FREE))
[ "$USED" -lt 0 ] && USED=0

if [ "$USED" -ge 85 ]; then
  COLOR="$COLOR_PINK"
elif [ "$USED" -ge 65 ]; then
  COLOR="$COLOR_ORANGE"
else
  COLOR="$COLOR_GREEN"
fi

sketchybar --set "$NAME" \
  icon="󰘚" \
  icon.color="$COLOR" \
  label="$USED%" \
  label.color="$COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on
