# 未読の GitHub 通知件数を表示する。
#
# ネットワークを叩くので更新間隔は長め。通知が無いときと、認証切れなどで
# 件数が取れなかったときはアイテムごと隠す。
COUNT="$(gh api notifications --jq 'length' 2>/dev/null)"

case "$COUNT" in
'' | *[!0-9]*)
  sketchybar --set "$NAME" drawing=off
  exit 0
  ;;
esac

if [ "$COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="" \
  icon.color="$COLOR_PURPLE" \
  label="$COUNT" \
  label.color="$COLOR_PURPLE" \
  background.color="$COLOR_BG" \
  background.drawing=on
