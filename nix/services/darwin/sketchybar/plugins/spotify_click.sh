# AppleScript内で起動確認と再生トグルを一括で行う
# - pgrep + 複数osascript のレースコンディションを解消
# - Spotifyが起動していない場合は何もしない（自動起動を防止）
osascript -e '
if application "Spotify" is not running then return
tell application "Spotify"
  if player state is playing then
    pause
  else
    play
  end if
end tell
' 2>/dev/null

# SketchyBarを更新
sketchybar --trigger spotify_update
