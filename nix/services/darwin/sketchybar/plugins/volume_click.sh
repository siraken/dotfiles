# 出力デバイス一覧を popup に流し込んでから開閉する。
#
# デバイス数は接続状況で変わるのに popup のアイテムは事前に作っておく必要があるため、
# スロットを固定数用意して使う分だけ描画する。スロットを超えた分は表示できないので、
# 溢れたときは最後のスロットにその旨を出す。
DEVICE_PLUGIN="$1"
SLOTS=16

CURRENT="$(SwitchAudioSource -c -t output 2>/dev/null)"

args=()
i=0
overflow=0

while IFS= read -r device; do
  [ -n "$device" ] || continue

  if [ "$i" -ge "$SLOTS" ]; then
    overflow=$((overflow + 1))
    continue
  fi

  if [ "$device" = "$CURRENT" ]; then
    icon="󰄬"
    icon_color="$COLOR_PINK"
    label_color="$COLOR_WHITE"
  else
    icon="󰕾"
    icon_color="$COLOR_MUTED"
    label_color="$COLOR_MUTED"
  fi

  # デバイス名に空白や記号が含まれても壊れないように click_script 用に引用する
  printf -v quoted '%q' "$device"

  args+=(
    --set "volume.popup.device.$i"
    drawing=on
    icon="$icon"
    icon.color="$icon_color"
    label="$device"
    label.color="$label_color"
    click_script="$DEVICE_PLUGIN $quoted"
  )
  i=$((i + 1))
done < <(SwitchAudioSource -a -t output 2>/dev/null)

if [ "$overflow" -gt 0 ] && [ "$SLOTS" -gt 0 ]; then
  last=$((SLOTS - 1))
  args+=(
    --set "volume.popup.device.$last"
    drawing=on
    icon="󰕾"
    icon.color="$COLOR_MUTED"
    label="... and $overflow more"
    label.color="$COLOR_MUTED"
    click_script=""
  )
fi

while [ "$i" -lt "$SLOTS" ]; do
  args+=(--set "volume.popup.device.$i" drawing=off)
  i=$((i + 1))
done

sketchybar "${args[@]}" --set "$NAME" popup.drawing=toggle
