# 出力デバイスによっては AppleScript が音量を返さない（Bluetooth ヘッドセットなど。
# `get volume settings` の output volume が missing value になる）。
# sketchybar の volume_change は CoreAudio 由来なのでその場合でも値が届くため、
# 受け取った値をここに控えておき、スクロール時の基準として使う。
VOLUME_STATE="${TMPDIR:-/tmp}/sketchybar-volume"

# `get volume settings` の出力は
# "output volume:81, input volume:27, alert volume:100, output muted:false"
# の形式。1 回の osascript 呼び出しから音量とミュート状態を両方取り出す。
read_volume_settings() {
  local settings
  settings="$(osascript -e 'get volume settings' 2>/dev/null)"
  VOL_SETTING=""
  MUTED_SETTING=""
  if [[ $settings =~ output\ volume:[[:space:]]*([0-9]+) ]]; then
    VOL_SETTING="${BASH_REMATCH[1]}"
  fi
  if [[ $settings =~ output\ muted:[[:space:]]*(true|false) ]]; then
    MUTED_SETTING="${BASH_REMATCH[1]}"
  fi
}

read_saved_volume() {
  local value=""
  if [ -r "$VOLUME_STATE" ]; then
    IFS= read -r value <"$VOLUME_STATE" || true
  fi
  case "$value" in
  '' | *[!0-9]*) return 1 ;;
  esac
  printf '%s' "$value"
}

save_volume() {
  local value="$1"
  local tmp
  tmp="$(mktemp "${VOLUME_STATE}.XXXXXX" 2>/dev/null)" || return 1
  if printf '%s\n' "$value" >"$tmp" 2>/dev/null; then
    mv -f "$tmp" "$VOLUME_STATE" 2>/dev/null || rm -f "$tmp"
  else
    rm -f "$tmp"
  fi
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
  if [ "$DIRECTION" != "0" ]; then
    read_volume_settings
    CURRENT="$VOL_SETTING"
    if [ -z "$CURRENT" ]; then
      CURRENT="$(read_saved_volume)" || CURRENT=""
    fi
    if [ -n "$CURRENT" ]; then
      NEXT=$((CURRENT + DIRECTION * 5))
      if [ "$NEXT" -lt 0 ]; then
        NEXT=0
      elif [ "$NEXT" -gt 100 ]; then
        NEXT=100
      fi
      osascript -e "set volume output volume $NEXT" 2>/dev/null
    fi
  fi
  exit 0
fi

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
  case "$VOLUME" in
  '' | *[!0-9]*) ;;
  *)
    # ミュート時は volume_change が 0 を送ってくるため、既存の非ゼロ値を
    # 0 で上書きしない（未作成時のみ 0 も記録してスクロール基準を確保する）
    if [ "$VOLUME" -gt 0 ] || [ ! -s "$VOLUME_STATE" ]; then
      save_volume "$VOLUME"
    fi
    ;;
  esac
else
  read_volume_settings
  if [ "$MUTED_SETTING" = "true" ]; then
    VOLUME=0
  else
    VOLUME="$VOL_SETTING"
    if [ -z "$VOLUME" ]; then
      VOLUME="$(read_saved_volume)" || VOLUME=""
    fi
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
