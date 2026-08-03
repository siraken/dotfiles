# 出力デバイスによっては AppleScript が音量を返さない（Bluetooth ヘッドセットなど。
# `get volume settings` の output volume が missing value になる）。
# sketchybar の volume_change は CoreAudio 由来なのでその場合でも値が届くため、
# 受け取った値をここに控えておき、スクロール時の基準として使う。
VOLUME_STATE="${TMPDIR:-/tmp}/sketchybar-volume"

read_volume() {
  local value
  value="$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)"
  case "$value" in
  '' | *[!0-9]*)
    value="$(cat "$VOLUME_STATE" 2>/dev/null)"
    ;;
  esac
  case "$value" in
  '' | *[!0-9]*) return 1 ;;
  esac
  printf '%s' "$value"
}

# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

# バー上のスクロールで音量を上下する。
# 音量を変えると volume_change が飛んでくるので、描画はそちらに任せる。
if [ "$SENDER" = "mouse.scrolled" ]; then
  DIRECTION="$(awk -v d="$SCROLL_DELTA" 'BEGIN { print (d > 0 ? 1 : (d < 0 ? -1 : 0)) }')"
  if [ "$DIRECTION" != "0" ] && CURRENT="$(read_volume)"; then
    NEXT=$((CURRENT + DIRECTION * 5))
    if [ "$NEXT" -lt 0 ]; then
      NEXT=0
    elif [ "$NEXT" -gt 100 ]; then
      NEXT=100
    fi
    osascript -e "set volume output volume $NEXT" 2>/dev/null
  fi
  exit 0
fi

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
  case "$VOLUME" in
  '' | *[!0-9]*) ;;
  *) printf '%s' "$VOLUME" >"$VOLUME_STATE" ;;
  esac
else
  VOLUME="$(read_volume)" || VOLUME=""
  MUTED="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null)"
  if [ "$MUTED" = "true" ]; then
    VOLUME=0
  fi
fi

# 値が取れないときは数字を出さない（古い値が残り続けるのを避ける）
if [ -z "$VOLUME" ]; then
  sketchybar --set "$NAME" \
    icon="󰕾" \
    icon.color="$COLOR_MUTED" \
    label.drawing=off \
    background.color="$COLOR_BG" \
    background.drawing=on
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
  label="$VOLUME%" \
  label.color="$COLOR_PINK" \
  label.drawing=on \
  background.color="$COLOR_BG" \
  background.drawing=on \
  --set volume.popup.slider slider.percentage="$VOLUME"
