# 再生中のアプリに操作を送る。
#
# - 再生中のものがあればそれを、無ければ起動中のもの（Spotify 優先）を対象にする
# - 起動していないアプリは触らない（自動起動を防止）
case "$1" in
previous) COMMAND="previous track" ;;
next) COMMAND="next track" ;;
toggle) COMMAND="playpause" ;;
*) exit 0 ;;
esac

osascript <<APPLESCRIPT 2>/dev/null
with timeout of 5 seconds
	if application "Spotify" is running then
		tell application "Spotify"
			if player state is playing then
				$COMMAND
				return
			end if
		end tell
	end if
	if application "Music" is running then
		tell application "Music"
			if player state is playing then
				$COMMAND
				return
			end if
		end tell
	end if
	if application "Spotify" is running then
		tell application "Spotify" to $COMMAND
		return
	end if
	if application "Music" is running then
		tell application "Music" to $COMMAND
	end if
end timeout
APPLESCRIPT

# アプリ側の状態が切り替わるのを待ってから再描画する
# （ポーリング間隔を伸ばしているため、操作時は明示的に更新する）
sleep 0.2
sketchybar --trigger media_update
