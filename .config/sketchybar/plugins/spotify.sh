#!/bin/sh

# Spotifyが起動しているか確認
if ! pgrep -x "Spotify" >/dev/null; then
  sketchybar --set "$NAME" label="Not running" icon=󰓛 icon.color=0xff9399b2 background.color=0xff1a1b26
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
    ICON_COLOR=0xfff7768e
    ;;
  *)
    ICON=󰓛
    ICON_COLOR=0xff9399b2
    ;;
esac

# 曲名とアーティスト名を結合（最大30文字）
if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
  LABEL="$TRACK_NAME - $ARTIST_NAME"
  if [ ${#LABEL} -gt 30 ]; then
    LABEL="${LABEL:0:27}..."
  fi
else
  LABEL="Not playing"
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  background.color=0xff1a1b26
