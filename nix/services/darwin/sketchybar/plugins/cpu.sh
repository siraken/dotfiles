# CPU 使用率を graph に流し込む。
#
# ps の %cpu は各プロセスの減衰平均なので厳密な瞬間値ではないが、
# top -l 1 は実測で 1.3 秒かかるため、軽さを優先してこちらを使う。
CORES="$(sysctl -n hw.ncpu 2>/dev/null)"
case "$CORES" in
'' | *[!0-9]*) exit 0 ;;
esac
[ "$CORES" -gt 0 ] || exit 0

TOTAL="$(ps -A -o %cpu | awk '{ s += $1 } END { printf "%.0f", s }')"
case "$TOTAL" in
'' | *[!0-9]*) exit 0 ;;
esac

USAGE=$((TOTAL / CORES))
[ "$USAGE" -gt 100 ] && USAGE=100

if [ "$USAGE" -ge 80 ]; then
  COLOR="$COLOR_PINK"
elif [ "$USAGE" -ge 50 ]; then
  COLOR="$COLOR_ORANGE"
else
  COLOR="$COLOR_GREEN"
fi

# graph は 0.0-1.0 でデータ点を受ける
RATIO="$(awk -v u="$USAGE" 'BEGIN { printf "%.3f", u / 100 }')"

# 塗りつぶしは線と同じ色を薄くしたもの（色は 0xffRRGGBB 形式）
FILL="0x33${COLOR#0xff}"

sketchybar --push "$NAME" "$RATIO" \
  --set "$NAME" \
  icon.color="$COLOR" \
  label="$USAGE%" \
  label.color="$COLOR" \
  graph.color="$COLOR" \
  graph.fill_color="$FILL" \
  background.color="$COLOR_BG" \
  background.drawing=on
