# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
#
# アプリのアイコンはワークスペース側（sketchybar-app-font）で表示しているため、
# ここではタイトルのみを出す。icon の余白も落として左右対称にする。

FRONT_APP="$(/usr/bin/lsappinfo info -only name $(/usr/bin/lsappinfo front) | cut -d '"' -f4)"

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
