# AeroSpace の全ワークスペース表示をまとめて更新する。
#
# 引数には設定時に確定したワークスペース ID（アイテム space.<id> と 1:1 対応）を渡す。
# ワークスペースごとに個別スクリプトを走らせず、この 1 本で全アイテムを更新することで
# aerospace CLI の呼び出しを 2 回に抑えている。

# ワークスペース状態（フォーカス・表示・所属モニタ）を 1 回の呼び出しで取得する。
# NSScreen の番号は sketchybar の display 番号と一致するのでそのまま使える
# （aerospace の monitor-id とは並び順が異なる）。
# 起動直後や一時的なエラーで aerospace が応答しない場合は既存の表示を触らず終了する。
WORKSPACES="$(aerospace list-workspaces --all --format '%{workspace}|%{workspace-is-focused}|%{workspace-is-visible}|%{monitor-appkit-nsscreen-screens-id}')" || exit 0
[ -n "$WORKSPACES" ] || exit 0

WINDOWS="$(aerospace list-windows --all --format '%{workspace}|%{app-name}')" || exit 0

FOCUSED=""
declare -A ws_visible=()
declare -A ws_display=()

while IFS='|' read -r ws is_focused is_visible display; do
  [ -n "$ws" ] || continue
  if [ "$is_focused" = "true" ]; then
    FOCUSED="$ws"
  fi
  if [ "$is_visible" = "true" ]; then
    ws_visible["$ws"]=1
  fi
  if [ -n "$display" ]; then
    ws_display["$ws"]="$display"
  fi
done <<<"$WORKSPACES"

[ -n "$FOCUSED" ] || exit 0

# 1 パスでワークスペースごとのアプリ名を重複排除しつつ集める
declare -A seen_app=()
declare -A ws_apps=()

while IFS='|' read -r ws app; do
  [ -n "$ws" ] && [ -n "$app" ] || continue
  key="$ws|$app"
  if [[ -z "${seen_app["$key"]+x}" ]]; then
    seen_app["$key"]=1
    ws_apps["$ws"]+="$app"$'\n'
  fi
done <<<"$WINDOWS"

args=()

for sid in "$@"; do
  # ワークスペース内のアプリを決定的な順序に並べ、sketchybar-app-font のリガチャ列に変換する
  icons=""
  if [[ -n "${ws_apps["$sid"]+x}" ]]; then
    mapfile -t apps <<<"${ws_apps["$sid"]%$'\n'}"
    for ((i = 1; i < ${#apps[@]}; i++)); do
      cur="${apps[i]}"
      j=$((i - 1))
      while ((j >= 0)) && [[ "${apps[j]}" > "$cur" ]]; do
        apps[j + 1]="${apps[j]}"
        j=$((j - 1))
      done
      apps[j + 1]="$cur"
    done
    for app in "${apps[@]}"; do
      __icon_map "$app"
      icons="${icons:+$icons }$icon_result"
    done
  fi

  if [ "$sid" = "$FOCUSED" ]; then
    # 塗りつぶしの上なので、文字は島の地の色にして輪郭を立たせる
    drawing=on
    background="$COLOR_FOCUS_FILL"
    foreground="$COLOR_BG"
  elif [[ -n "${ws_visible["$sid"]+x}" ]]; then
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
  display="${ws_display["$sid"]:-}"
  if [ -n "$display" ]; then
    args+=(display="$display")
  fi
done

sketchybar "${args[@]}"
