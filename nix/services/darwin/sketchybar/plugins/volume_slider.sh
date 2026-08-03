# popup のスライダーをドラッグ/クリックした位置から音量を設定する。
# $PERCENTAGE はスライダー上の位置を 0-100 で sketchybar が渡してくる。
# 設定すると volume_change が飛ぶので、描画は volume.sh に任せる。
case "$PERCENTAGE" in
'' | *[!0-9]*) exit 0 ;;
esac

osascript -e "set volume output volume $PERCENTAGE" 2>/dev/null
