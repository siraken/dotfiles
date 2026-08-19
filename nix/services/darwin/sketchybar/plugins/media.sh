# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

# ラベルの上限幅（ピクセル）。ノッチを避けるための値で default.nix から渡される。
LABEL_MAX_WIDTH="${1:-204}"

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

# Apple Music はライブラリに入っていないストリーミング曲だと current track が
# 取得できず（-1728）、曲名が空で返る。その場合はアプリ名にフォールバックする。
if [ -z "$TRACK" ]; then
  LABEL="$SOURCE_NAME"
elif [ -n "$ARTIST" ]; then
  LABEL="$TRACK | $ARTIST"
else
  LABEL="$TRACK"
fi

# ラベルの幅は sketchybar 側では固定していない（label.width は既定の dynamic）。
# 短い曲名で島が間延びしないよう文字に合わせて縮ませ、代わりに上限幅を超えた分を
# ここで「…」に置き換える。
#
# 1 文字の幅は Hack Nerd Font 12pt での実測値による近似で、
# 全角（East Asian Wide / Fullwidth）12px、絵文字 16px、それ以外 7.2px。
# フォールバック先のフォント次第で数 px ずれるが、上限に対しては無視できる。
LABEL="$(
  printf '%s' "$LABEL" | perl -CS -e '
    use utf8;

    sub char_width {
      my ($c) = @_;
      return 16 if $c =~ /\p{Emoji_Presentation}/; # 既定で絵文字として描かれる文字
      return 8.8 if $c eq "\x{FE0F}";              # 絵文字にする異体字セレクタの差分
      return 0 if $c =~ /\p{Mn}|\p{Cf}/;          # 合成用の記号や ZWJ
      return 12 if $c =~ /\p{Ea=W}|\p{Ea=F}/;     # 全角
      return 7.2;                                  # 半角
    }

    my $budget = $ARGV[0];
    my @chars = split //, do { local $/; <STDIN> };

    my $total = 0;
    $total += char_width($_) for @chars;
    if ($total <= $budget) { print @chars; exit }

    # 末尾の「…」の分を空けてから詰める。切れ目が単語の区切りに当たったときに
    # 「…」の前が空くのを避けるため、末尾の空白は落とす。
    my $limit = $budget - char_width("…");
    my ($width, $truncated) = (0, "");
    for my $c (@chars) {
      last if $width + char_width($c) > $limit;
      $width += char_width($c);
      $truncated .= $c;
    }
    $truncated =~ s/\s+$//;
    print $truncated, "…";
  ' "$LABEL_MAX_WIDTH"
)"

sketchybar --set "$NAME" \
  drawing=on \
  icon="$ICON" \
  icon.color="$ICON_COLOR" \
  label="$LABEL" \
  label.color="$LABEL_COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on \
  --set media.popup.play icon="$PLAY_ICON"
