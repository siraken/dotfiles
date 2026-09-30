# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
#
# アプリのアイコンはワークスペース側（sketchybar-app-font）で表示しているため、
# ここではタイトルのみを出す。icon の余白も落として左右対称にする。

#
# $INFO が空になる起動直後 (SENDER=forced) だけ lsappinfo に問い合わせる。
# macOS 27 から -only が無視され、1 行目が `"LSDisplayName"="Foo"` ではなく
# `"Foo" ASN:... (in front)` になった上に後続行まで出力されるようになった。
# どちらの形でも名前は 1 行目の最後の引用符の中にあるので、そこだけを取る。
if [[ $SENDER == "front_app_switched" ]]; then
  FRONT_APP="$INFO"
else
  FRONT_APP="$(/usr/bin/lsappinfo info -only name "$(/usr/bin/lsappinfo front)" |
    sed -n '1s/.*"\([^"]*\)".*/\1/p')"
fi

if [[ $FRONT_APP == "" ]]; then
  FRONT_APP="Desktop"
fi

sketchybar --set "$NAME" \
  icon.drawing=off \
  icon.padding_left=0 \
  icon.padding_right=0 \
  label="$FRONT_APP" \
  background.color="$COLOR_BG" \
  background.drawing=on
