# Musicが起動しているか確認
if ! pgrep -x "Music" >/dev/null; then
  exit 0
fi

# Musicの現在の再生状態を取得
PLAYER_STATE=$(osascript -e 'tell application "Music" to player state as string')

# 再生状態に応じてトグル
case "$PLAYER_STATE" in
  "playing")
    # 再生中の場合は一時停止
    osascript -e 'tell application "Music" to pause'
    ;;
  "paused")
    # 一時停止中の場合は再生
    osascript -e 'tell application "Music" to play'
    ;;
  *)
    # その他の状態（停止中など）の場合は再生
    osascript -e 'tell application "Music" to play'
    ;;
esac

# SketchyBarを更新
sketchybar --trigger music_update
