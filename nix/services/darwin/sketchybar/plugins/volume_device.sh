# popup で選ばれた出力デバイスに切り替える。
#
# デバイスごとに音量が別管理なので、切り替え後に volume_update を投げて
# バーの表示とスライダーを現在値に合わせ直す。
[ -n "$1" ] || exit 0

SwitchAudioSource -s "$1" -t output >/dev/null 2>&1

sketchybar --set volume popup.drawing=off
sketchybar --trigger volume_update
