# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

# ラベルの上限幅（ピクセル）。ノッチを避けるための値で default.nix から渡される。
LABEL_MAX_WIDTH="${1:-204}"

# 前回描画した状態を控えておき、曲や再生状態が変わっていないときは
# perl の起動と sketchybar への再描画を省く。
# forced（起動時や --update）および手動実行時はキャッシュを無視して必ず反映する。
MEDIA_STATE="${TMPDIR:-/tmp}/sketchybar-media"
PREV_STATE=""
if [ "$SENDER" != "forced" ] && [ -n "$SENDER" ] && [ -r "$MEDIA_STATE" ]; then
  IFS= read -r PREV_STATE <"$MEDIA_STATE" || true
fi

# どちらも起動していなければ osascript を呼ばずに終了する
if ! pgrep -xq 'Spotify|Music'; then
  if [ "$PREV_STATE" != "off" ]; then
    sketchybar --set "$NAME" drawing=off popup.drawing=off
    printf '%s\n' "off" >"$MEDIA_STATE"
  fi
  exit 0
fi

# Spotify と Apple Music を 1 回の osascript でまとめて問い合わせる。
#
# - `application "X" is running` はアプリを起動させずに状態を確認できる安全な判定方法
# - 2 つのアプリで別々のアイテム・別々のポーリングを持たせず、1 本に統合している
# - 区切りに US (0x1F) を使うのは曲名に "|" 等が含まれても壊れず、かつ bash の read が
#   タブのように連続した空フィールドを 1 つに潰さないようにするため
# - with timeout でアプリが応答しない場合のハングを防ぐ

MEDIA_INFO="$(
  osascript <<'APPLESCRIPT' 2>/dev/null
set output to ""
set sep to character id 31
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
		set output to output & "spotify" & sep & playerState & sep & trackName & sep & artistName & linefeed
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
		set output to output & "music" & sep & playerState & sep & trackName & sep & artistName & linefeed
	end if
end timeout
return output
APPLESCRIPT
)"

# 表示するソースの優先順位:
#   1. 再生中かつ曲名が取れているもの
#   2. 再生中のもの（Apple Music はライブラリ外の曲だと曲名が取れないためここに落ちる）
#   3. 再生中ではないが曲名が取れているもの
SOURCE=""
STATE=""
TRACK=""
ARTIST=""
BEST_PRIORITY=99

while IFS=$'\x1f' read -r row_source row_state row_track row_artist; do
  [ -n "$row_source" ] || continue
  if [ "$row_state" = "playing" ] && [ -n "$row_track" ]; then
    priority=1
  elif [ "$row_state" = "playing" ]; then
    priority=2
  elif [ -n "$row_track" ]; then
    priority=3
  else
    continue
  fi

  if [ "$priority" -lt "$BEST_PRIORITY" ]; then
    BEST_PRIORITY="$priority"
    SOURCE="$row_source"
    STATE="$row_state"
    TRACK="$row_track"
    ARTIST="$row_artist"
    [ "$priority" -eq 1 ] && break
  fi
done <<<"$MEDIA_INFO"

# どちらも起動していない、または再生対象が無い場合はアイテムごと隠す
if [ -z "$SOURCE" ]; then
  if [ "$PREV_STATE" != "off" ]; then
    sketchybar --set "$NAME" drawing=off popup.drawing=off
    printf '%s\n' "off" >"$MEDIA_STATE"
  fi
  exit 0
fi

# 状態が変わっていなければ perl の起動と再描画を省く
STATE_KEY="${LABEL_MAX_WIDTH}"$'\t'"${SOURCE}"$'\t'"${STATE}"$'\t'"${TRACK}"$'\t'"${ARTIST}"
if [ "$STATE_KEY" = "$PREV_STATE" ]; then
  exit 0
fi

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
# 1 文字あたりの最大幅（16px）で見積もっても上限に収まる短い文字列は perl を呼ばない。
if ((${#LABEL} * 16 > LABEL_MAX_WIDTH)); then
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

printf '%s\n' "$STATE_KEY" >"$MEDIA_STATE"
