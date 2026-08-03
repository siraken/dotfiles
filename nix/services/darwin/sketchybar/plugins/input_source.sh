# 現在の入力ソースを表示する。
#
# 入力ソースの変更には専用のイベントが無いが、システムが
# AppleSelectedInputSourcesChangedNotification を配信しているので、
# sketchybar の --add event で購読しイベント駆動にしている（ポーリング不要）。
#
# AppleSelectedInputSources は選択中のソースを 1 件返す。IME かどうかで
# 識別子の入る場所が違う。
#
#   ABC       -> "KeyboardLayout Name" = ABC;
#   ことえり  -> "Input Mode" = "com.apple.inputmethod.Japanese";
#
# 言語を増やしたら下の対応表に 1 行足す。識別子は入力ソースを切り替えながら
#   defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources
# を実行すると確認できる。
SOURCE_ID="$(
  defaults read "$HOME/Library/Preferences/com.apple.HIToolbox.plist" AppleSelectedInputSources 2>/dev/null |
    awk -F' = ' '
      # 値側にも "Input Mode" という文字列が出る行があるので、キー側で判定する
      #   InputSourceKind = "Input Mode";      <- これに引っかけない
      $1 ~ /"Input Mode"$/          { mode = $2 }
      $1 ~ /"KeyboardLayout Name"$/ { layout = $2 }
      END {
        id = (mode != "" ? mode : layout)
        gsub(/[";]/, "", id)
        gsub(/^[ \t]+/, "", id)
        gsub(/[ \t]+$/, "", id)
        print id
      }
    '
)"

# 対応表: 識別子 -> 表示する文字と色。
# ラテン文字入力は白、IME が有効なものは緑にして周辺視でも分かるようにしている。
case "$SOURCE_ID" in
# 日本語 (ことえり)
com.apple.inputmethod.Japanese)
  LABEL="あ"
  COLOR="$COLOR_GREEN"
  ;;
com.apple.inputmethod.Japanese.Katakana)
  LABEL="ア"
  COLOR="$COLOR_GREEN"
  ;;
com.apple.inputmethod.Japanese.HalfWidthKana)
  LABEL="ｱ"
  COLOR="$COLOR_GREEN"
  ;;
com.apple.inputmethod.Japanese.FullWidthRoman)
  LABEL="Ａ"
  COLOR="$COLOR_GREEN"
  ;;
com.apple.inputmethod.Roman)
  LABEL="A"
  COLOR="$COLOR_WHITE"
  ;;
# ラテン文字のキーボードレイアウト
ABC | US | U.S. | Australian | British | Canadian | Irish)
  LABEL="A"
  COLOR="$COLOR_WHITE"
  ;;
# 使い始めたら有効にする。識別子は上のコマンドで実際の値を確認してから入れること。
# com.apple.inputmethod.Korean.2SetKorean) LABEL="한" COLOR="$COLOR_GREEN" ;;
# com.apple.inputmethod.SCIM.ITABC) LABEL="拼" COLOR="$COLOR_GREEN" ;;
# com.apple.inputmethod.TCIM.Zhuyin) LABEL="注" COLOR="$COLOR_GREEN" ;;
# Russian) LABEL="Я" COLOR="$COLOR_WHITE" ;;
# German) LABEL="DE" COLOR="$COLOR_WHITE" ;;
*)
  # 未登録のソースでも空欄にはせず、識別子の末尾から 2 文字を大文字で出す
  LABEL="$(printf '%s' "${SOURCE_ID##*.}" | cut -c1-2 | tr '[:lower:]' '[:upper:]')"
  COLOR="$COLOR_MUTED"
  ;;
esac

if [ -z "$LABEL" ]; then
  LABEL="?"
  COLOR="$COLOR_MUTED"
fi

sketchybar --set "$NAME" \
  icon="󰌌" \
  icon.color="$COLOR" \
  label="$LABEL" \
  label.color="$COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on
