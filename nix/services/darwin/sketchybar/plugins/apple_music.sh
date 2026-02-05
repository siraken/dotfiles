_COLOR_DEFAULT_BACKGROUND=0xff1a1b26
_COLOR_BRAND=0xffff4e6b

# Apple Musicが起動しているか確認
if ! pgrep -x "Music" >/dev/null; then
  sketchybar -m --set "$NAME" \
    drawing=off
  exit 0
fi

# AppleScriptを使用してApple Musicの情報を取得
PLAYER_STATE=$(osascript -e 'tell application "Music" to player state as string')
TRACK_NAME=$(osascript -e 'tell application "Music" to name of current track as string')
ARTIST_NAME=$(osascript -e 'tell application "Music" to artist of current track as string')

# 再生状態に応じてアイコンを設定
case "$PLAYER_STATE" in
"playing")
  ICON=󰐊
  ICON_COLOR=0xffffffff
  LABEL_COLOR=0xffffffff
  BACKGROUND_COLOR=$_COLOR_BRAND
  ;;
"paused")
  ICON=󰏤
  ICON_COLOR=0xfffa233f
  LABEL_COLOR=0xffffffff
  BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
  ;;
*)
  ICON=󰓛
  ICON_COLOR=0xfffa233f
  LABEL_COLOR=0xffffffff
  BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
  ;;
esac

# 曲名とアーティスト名を結合して文字数を制限
if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
  # まず結合
  LABEL="$TRACK_NAME | $ARTIST_NAME"

  # 24文字を超える場合は省略
  if [ ${#LABEL} -gt 24 ]; then
    LABEL="${LABEL:0:24}..."
  fi
else
  LABEL="Not playing"
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  label.color="$LABEL_COLOR" \
  background.color="$BACKGROUND_COLOR" \
  background.drawing=on
