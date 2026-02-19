_COLOR_DEFAULT_BACKGROUND=0xff1a1b26
_COLOR_DEFAULT_GREEN=0xff9ece6a
_COLOR_BRAND=0xff1ed760
_COLOR_WHITE=0xffffffff

# AppleScript内で起動確認と情報取得を一括で行う
# - `application "Spotify" is not running` はSpotifyを起動させない安全な確認方法
# - 1回のosascript呼び出しに統合し、プロセス増殖とレースコンディションを防止
# - `with timeout` でSpotifyが応答しない場合のハングを防止
SPOTIFY_INFO=$(osascript -e '
if application "Spotify" is not running then
  return "NOT_RUNNING"
end if
with timeout 5 seconds
  tell application "Spotify"
    set playerState to player state as string
    set trackName to name of current track as string
    set artistName to artist of current track as string
    return playerState & "|" & trackName & "|" & artistName
  end tell
end timeout
' 2>/dev/null)

# Spotifyが起動していない、またはosascriptが失敗した場合
if [ -z "$SPOTIFY_INFO" ] || [ "$SPOTIFY_INFO" = "NOT_RUNNING" ]; then
  sketchybar --set "$NAME" \
    drawing=off
  exit 0
fi

# パイプ区切りで分割
PLAYER_STATE=$(echo "$SPOTIFY_INFO" | cut -d'|' -f1)
TRACK_NAME=$(echo "$SPOTIFY_INFO" | cut -d'|' -f2)
ARTIST_NAME=$(echo "$SPOTIFY_INFO" | cut -d'|' -f3)

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
  LABEL_COLOR=$_COLOR_WHITE
  BACKGROUND_COLOR=$_COLOR_DEFAULT_BACKGROUND
  ;;
esac

# 曲名とアーティスト名を結合して文字数を制限
if [ "$PLAYER_STATE" = "playing" ] || [ "$PLAYER_STATE" = "paused" ]; then
  # 規定文字数を超える場合は省略
  if [ ${#TRACK_NAME} -gt 24 ]; then
    TRACK_NAME="${TRACK_NAME:0:24}..."
  fi

  if [ ${#ARTIST_NAME} -gt 24 ]; then
    ARTIST_NAME="${ARTIST_NAME:0:24}..."
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
