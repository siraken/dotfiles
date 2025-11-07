#!/bin/sh

_COLOR_DEFAULT_BACKGROUND=0xff1a1b26
_COLOR_DEFAULT_GREEN=0xff9ece6a
_COLOR_BRAND=0xff1ed760
_COLOR_WHITE=0xffffffff

# Spotifyが起動しているか確認
if ! pgrep -x "Spotify" >/dev/null; then
  sketchybar --set "$NAME" \
    drawing=off
  exit 0
fi

# AppleScriptを使用してSpotifyの情報を取得
PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state as string')
TRACK_NAME=$(osascript -e 'tell application "Spotify" to name of current track as string')
ARTIST_NAME=$(osascript -e 'tell application "Spotify" to artist of current track as string')

# 再生状態に応じてアイコンを設定
case "$PLAYER_STATE" in
  "playing")
    ICON_COLOR=$_COLOR_BRAND
    LABEL_COLOR=$_COLOR_WHITE
    BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
    ;;
  "paused")
    ICON_COLOR=$_COLOR_WHITE
    LABEL_COLOR=$_COLOR_WHITE
    BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
    ;;
  *)
    ICON_COLOR=$_COLOR_WHITE
    LABEL_COLOR=$_WHITE_COLOR
    BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
    ;;
esac

# 曲名とアーティスト名を結合して文字数を制限
if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
  # 規定文字数を超える場合は省略
  if [ ${#TRACK_NAME} -gt 18 ]; then
    TRACK_NAME="${TRACK_NAME:0:18}..."
  fi

  if [ ${#ARTIST_NAME} -gt 18 ]; then
    ARTIST_NAME="${ARTIST_NAME:0:18}..."
  fi

  # 結合
  LABEL="$TRACK_NAME | $ARTIST_NAME"
else
  LABEL="Not playing"
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  label.color="$LABEL_COLOR" \
  background.color="$BACKGROUND_COLOR" \
  background.drawing=on
