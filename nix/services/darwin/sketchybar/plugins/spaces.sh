# AeroSpace の全ワークスペース表示をまとめて更新する。
#
# 引数には設定時に確定したワークスペース ID（アイテム space.<id> と 1:1 対応）を渡す。
# ワークスペースごとに個別スクリプトを走らせず、この 1 本で全アイテムを更新することで
# aerospace CLI の呼び出しを 4 回に抑えている。

# aerospace_workspace_change から渡る FOCUSED_WORKSPACE があればそれを使う
FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
# 各モニタで表示中のワークスペース（マルチモニタでフォーカス外の面も控えめに強調する）
VISIBLE=" $(aerospace list-workspaces --monitor all --visible | tr '\n' ' ') "
WINDOWS="$(aerospace list-windows --all --format '%{workspace}|%{app-name}')"
# ワークスペースが乗っているモニタ。NSScreen の番号は sketchybar の display 番号と
# 一致するのでそのまま使える（aerospace の monitor-id とは並び順が異なる）。
DISPLAYS="$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-appkit-nsscreen-screens-id}')"

args=()

for sid in "$@"; do
  # ワークスペース内のアプリを重複排除し、sketchybar-app-font のリガチャ列に変換する
  icons=""
  while IFS= read -r app; do
    [ -n "$app" ] || continue
    __icon_map "$app"
    icons="${icons:+$icons }$icon_result"
  done < <(printf '%s\n' "$WINDOWS" | awk -F'|' -v ws="$sid" '$1 == ws { print $2 }' | sort -u)

  case "$VISIBLE" in
  *" $sid "*) visible=yes ;;
  *) visible=no ;;
  esac

  if [ "$sid" = "$FOCUSED" ]; then
    drawing=on
    background="$COLOR_PURPLE_FILL"
    foreground="$COLOR_WHITE"
  elif [ "$visible" = yes ]; then
    # 他モニタで表示中のワークスペースは一段暗い面で示す
    drawing=on
    background="$COLOR_SURFACE"
    foreground="$COLOR_WHITE"
  elif [ -n "$icons" ]; then
    drawing=on
    background="$COLOR_TRANSPARENT"
    foreground="$COLOR_MUTED"
  else
    # ウィンドウが無く、どのモニタにも出ていないワークスペースは隠す
    drawing=off
    background="$COLOR_TRANSPARENT"
    foreground="$COLOR_MUTED"
  fi

  # アイコンが無いときは label 側の余白を全て落とし、代わりに icon の右余白で
  # 左右対称にする（label の描画有無に関わらず同じ見た目になるようにするため）
  if [ -n "$icons" ]; then
    label_drawing=on
    icon_padding_right=0
    label_padding_left=6
    label_padding_right=9
  else
    label_drawing=off
    icon_padding_right=9
    label_padding_left=0
    label_padding_right=0
  fi

  args+=(
    --animate sin 12
    --set "space.$sid"
    drawing="$drawing"
    background.color="$background"
    icon.color="$foreground"
    icon.padding_right="$icon_padding_right"
    label="$icons"
    label.color="$foreground"
    label.drawing="$label_drawing"
    label.padding_left="$label_padding_left"
    label.padding_right="$label_padding_right"
  )

  # そのワークスペースが属するモニタのバーにだけ出す。
  # 割り当てが読めなかった場合は今の設定を触らない。
  display="$(printf '%s\n' "$DISPLAYS" | awk -F'|' -v ws="$sid" '$1 == ws { print $2; exit }')"
  if [ -n "$display" ]; then
    args+=(display="$display")
  fi
done

sketchybar "${args[@]}"
