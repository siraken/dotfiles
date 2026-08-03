# volume_change のときはイベントが渡す $INFO を使い、それ以外（起動直後の
# 強制更新など）は現在の出力音量を問い合わせる。
# 従来は volume_change 以外で何も描画せず、起動直後に空のアイテムが残っていた。
if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)"
  MUTED="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null)"
  if [ "$MUTED" = "true" ]; then
    VOLUME=0
  fi
fi

if [ -z "$VOLUME" ] || [ "$VOLUME" = "missing value" ]; then
  exit 0
fi

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
  icon.color="$COLOR_PINK" \
  background.color="$COLOR_BG" \
  background.drawing=on \
  label="$VOLUME%" \
  label.color="$COLOR_PINK"
