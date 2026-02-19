# AppleScript内で起動確認と再生トグルを一括で行う
# - pgrep + 複数osascript のレースコンディションを解消
# - Apple Musicが起動していない場合は何もしない（自動起動を防止）
osascript -e '
if application "Music" is not running then return
tell application "Music"
  if player state is playing then
    pause
  else
    play
  end if
end tell
' 2>/dev/null

# SketchyBarを更新
sketchybar --trigger music_update
