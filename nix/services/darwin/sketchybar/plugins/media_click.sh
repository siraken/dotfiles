# 再生/一時停止をトグルする。
#
# - 再生中のアプリがあればそれを止める。無ければ起動中のアプリを再生する（Spotify 優先）
# - 起動していないアプリは触らない（自動起動を防止）
osascript <<'APPLESCRIPT' 2>/dev/null
with timeout of 5 seconds
	if application "Spotify" is running then
		tell application "Spotify"
			if player state is playing then
				pause
				return
			end if
		end tell
	end if
	if application "Music" is running then
		tell application "Music"
			if player state is playing then
				pause
				return
			end if
		end tell
	end if
	if application "Spotify" is running then
		tell application "Spotify" to play
		return
	end if
	if application "Music" is running then
		tell application "Music" to play
	end if
end timeout
APPLESCRIPT

# アプリ側の状態が切り替わるのを待ってから再描画する
# （ポーリング間隔を伸ばしているため、クリック時は明示的に更新する）
sleep 0.2
sketchybar --trigger media_update
