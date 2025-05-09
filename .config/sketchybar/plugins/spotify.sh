#!/bin/sh

# Spotifyが起動しているか確認
if ! pgrep -x "Spotify" >/dev/null; then
  sketchybar --set "$NAME" \
    label="Not running" \
    label.color=0xff9ece6a \
    icon=󰓛 \
    icon.color=0xff9399b2 \
    background.color=0xff1a1b26 \
    background.drawing=on
  exit 0
fi

# AppleScriptを使用してSpotifyの情報を取得
PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state as string')
TRACK_NAME=$(osascript -e 'tell application "Spotify" to name of current track as string')
ARTIST_NAME=$(osascript -e 'tell application "Spotify" to artist of current track as string')

# 再生状態に応じてアイコンを設定
case "$PLAYER_STATE" in
  "playing")
    ICON=󰐊
    ICON_COLOR=0xff9ece6a
    ;;
  "paused")
    ICON=󰏤
    ICON_COLOR=0xff9ece6a
    ;;
  *)
    ICON=󰓛
    ICON_COLOR=0xff9ece6a
    ;;
esac

# 曲名とアーティスト名を結合して文字数を制限
if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
  # まず結合
  LABEL="$TRACK_NAME - $ARTIST_NAME"

  # 24文字を超える場合は省略
  if [ ${#LABEL} -gt 24 ]; then
    LABEL="${LABEL:0:24}..."
  fi
else
  LABEL="Not playing"
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  label.color=0xff9ece6a \
  background.color=0xff1a1b26 \
  background.drawing=on
