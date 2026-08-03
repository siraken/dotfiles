# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

# Spotify と Apple Music を 1 回の osascript でまとめて問い合わせる。
#
# - `application "X" is running` はアプリを起動させずに状態を確認できる安全な判定方法
# - 2 つのアプリで別々のアイテム・別々のポーリングを持たせず、1 本に統合している
# - 区切りをタブにしているのは曲名やアーティスト名に "|" が含まれても壊れないようにするため
# - with timeout でアプリが応答しない場合のハングを防ぐ

MEDIA_INFO="$(
  osascript <<'APPLESCRIPT' 2>/dev/null
set output to ""
with timeout of 5 seconds
	if application "Spotify" is running then
		set trackName to ""
		set artistName to ""
		tell application "Spotify"
			set playerState to (player state as string)
			try
				set trackName to name of current track
				set artistName to artist of current track
			end try
		end tell
		set output to output & "spotify" & tab & playerState & tab & trackName & tab & artistName & linefeed
	end if
	if application "Music" is running then
		set trackName to ""
		set artistName to ""
		tell application "Music"
			set playerState to (player state as string)
			try
				set trackName to name of current track
				set artistName to artist of current track
			end try
		end tell
		set output to output & "music" & tab & playerState & tab & trackName & tab & artistName & linefeed
	end if
end timeout
return output
APPLESCRIPT
)"

# 表示するソースの優先順位:
#   1. 再生中かつ曲名が取れているもの
#   2. 再生中のもの（Apple Music はライブラリ外の曲だと曲名が取れないためここに落ちる）
#   3. 再生中ではないが曲名が取れているもの
LINE="$(printf '%s\n' "$MEDIA_INFO" | awk -F'\t' '$2 == "playing" && $3 != "" { print; exit }')"
if [ -z "$LINE" ]; then
  LINE="$(printf '%s\n' "$MEDIA_INFO" | awk -F'\t' '$2 == "playing" { print; exit }')"
fi
if [ -z "$LINE" ]; then
  LINE="$(printf '%s\n' "$MEDIA_INFO" | awk -F'\t' 'NF >= 4 && $3 != "" { print; exit }')"
fi

# どちらも起動していない、または再生対象が無い場合はアイテムごと隠す
if [ -z "$LINE" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

SOURCE="$(printf '%s' "$LINE" | cut -f1)"
STATE="$(printf '%s' "$LINE" | cut -f2)"
TRACK="$(printf '%s' "$LINE" | cut -f3)"
ARTIST="$(printf '%s' "$LINE" | cut -f4)"

case "$SOURCE" in
music)
  ICON="󰝚"
  BRAND_COLOR="$COLOR_APPLE_MUSIC"
  SOURCE_NAME="Apple Music"
  ;;
*)
  ICON=""
  BRAND_COLOR="$COLOR_SPOTIFY"
  SOURCE_NAME="Spotify"
  ;;
esac

if [ "$STATE" = "playing" ]; then
  ICON_COLOR="$BRAND_COLOR"
  LABEL_COLOR="$COLOR_WHITE"
  PLAY_ICON="󰏤"
else
  ICON_COLOR="$COLOR_MUTED"
  LABEL_COLOR="$COLOR_MUTED"
  PLAY_ICON="󰐊"
fi

# 長い曲名の切り詰めは label.max_chars + scroll_texts に任せる。
# Apple Music はライブラリに入っていないストリーミング曲だと current track が
# 取得できず（-1728）、曲名が空で返る。その場合はアプリ名にフォールバックする。
if [ -z "$TRACK" ]; then
  LABEL="$SOURCE_NAME"
elif [ -n "$ARTIST" ]; then
  LABEL="$TRACK | $ARTIST"
else
  LABEL="$TRACK"
fi

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  label.color="$LABEL_COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on \
  --set media.popup.play icon="$PLAY_ICON"
