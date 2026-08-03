# 現在の入力ソースを表示する。
#
# 入力ソースの変更には専用のイベントが無いが、システムが
# AppleSelectedInputSourcesChangedNotification を配信しているので、
# sketchybar の --add event で購読しイベント駆動にしている（ポーリング不要）。
SOURCE="$(defaults read "$HOME/Library/Preferences/com.apple.HIToolbox.plist" AppleSelectedInputSources 2>/dev/null | tr -d ' \n')"

case "$SOURCE" in
*.Japanese*)
  LABEL="JA"
  COLOR="$COLOR_GREEN"
  ;;
*)
  # ABC などのキーボードレイアウトと、ことえりの英字モード
  LABEL="EN"
  COLOR="$COLOR_WHITE"
  ;;
esac

sketchybar --set "$NAME" \
  icon="󰌌" \
  icon.color="$COLOR" \
  label="$LABEL" \
  label.color="$COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on
