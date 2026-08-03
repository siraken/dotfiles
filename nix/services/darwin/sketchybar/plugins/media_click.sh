# バーのメディアアイテムのクリック操作。
#
# - 左クリック: 再生 / 一時停止
# - 右クリック: popup（前へ・再生・次へ）の開閉
#
# $BUTTON が渡らない環境でも左クリック相当の動作に落ちるようにしている。
CONTROL_PLUGIN="$1"

if [ "$BUTTON" = "right" ]; then
  sketchybar --set "$NAME" popup.drawing=toggle
  exit 0
fi

"$CONTROL_PLUGIN" toggle
