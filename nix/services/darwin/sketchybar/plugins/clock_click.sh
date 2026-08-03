# popup にカレンダーを流し込んでから開閉する。
#
# cal は常に 8 行（月見出し + 曜日行 + 6 週分）を出力する。
# 1 行目の月見出しは自前の日付ヘッダで置き換えるため読み飛ばす。
#
# sketchybar はラベルの描画幅をインク（実際に描かれる範囲）で測るため、行頭の
# スペースは幅ゼロとして落とされてしまう。NBSP や Braille 空白でも同じなので、
# 行頭の字下げは自分で取り除き、label.padding_left に換算して与える。
# Hack は等幅で送り幅が 0.6em なので、12.0pt では 1 文字あたり 7.2px。
BASE_PADDING=12
CHAR_WIDTH_X10=72

mapfile -t CAL_LINES < <(cal)

args=(--set clock.popup.0 label="$(date '+%Y-%m-%d %a')")

i=1
while [ "$i" -le 7 ]; do
  line="${CAL_LINES[$i]-}"
  leading="${line%%[! ]*}"
  body="${line#"$leading"}"

  # 空白だけの行（月末の余り）は行ごと隠す
  if [ -n "$body" ]; then
    padding=$((BASE_PADDING + (${#leading} * CHAR_WIDTH_X10 + 5) / 10))
    args+=(--set "clock.popup.$i" label="$body" label.padding_left="$padding" drawing=on)
  else
    args+=(--set "clock.popup.$i" drawing=off)
  fi
  i=$((i + 1))
done

sketchybar "${args[@]}" --set "$NAME" popup.drawing=toggle
