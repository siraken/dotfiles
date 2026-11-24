# システムと home-manager の closure のうち、上流のバイナリキャッシュがどれも
# 持っていないパスだけを自前の Cachix へ push する。
#
# closure 全体は 1174 パス / 12.6 GiB あるが、上流に無いのは 214 パス /
# 286 MiB だけだった (2026-08-03 実測。mise 105MiB・1password-cli 77MiB・
# emacs パッケージ 99MiB・このリポジトリ由来の派生など)。丸ごと push すると
# 無料枠を使い切ってしまうため、narinfo の有無で絞り込んでいる。
#
# 引数を省くと /run/current-system と home-manager の profile のうち、存在する
# ものを対象にする。home-manager は OS とは別の standalone 構成なので、
# システムの closure には emacs パッケージや 1password-cli が入っていない。
#
# cachix の認証情報は 1Password Shell Plugin が持っているが、あれはシェル関数
# なのでスクリプトからは効かない。op があれば op plugin run 経由で呼ぶ。

CACHE="${CACHIX_CACHE:-siraken-dotfiles}"

if [ "$#" -gt 0 ]; then
  targets=("$@")
else
  targets=()
  for t in /run/current-system "${XDG_STATE_HOME:-$HOME/.local/state}/nix/profiles/home-manager"; do
    if [ -e "$t" ]; then
      targets+=("$t")
    fi
  done
  if [ "${#targets[@]}" -eq 0 ]; then
    echo 'push 対象がありません (/run/current-system も home-manager の profile も無い)' >&2
    exit 1
  fi
fi
printf '対象: %s\n' "${targets[@]}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

nix-store --query --requisites "${targets[@]}" | sort -u >"$tmp/closure"
awk -F/ '{ print substr($NF, 1, 32) }' "$tmp/closure" | sort -u >"$tmp/todo"
printf 'closure: %s パス\n' "$(wc -l <"$tmp/closure" | tr -d ' ')"

nix config show substituters | tr ' ' '\n' | sed '/^$/d; s:/*$::' | sort -u >"$tmp/hosts"

# 自前のキャッシュも問い合わせ対象に含める。既に載っているパスが落ちるので、
# 2 回目以降は差分だけが push 対象になる。
while read -r host; do
  [ -s "$tmp/todo" ] || break

  expected="$(wc -l <"$tmp/todo" | tr -d ' ')"

  # curl の -o は URL ごとの指定なので、設定ファイル側に書く必要がある。
  # リダイレクト後も元の URL からハッシュを取り出せるよう %{url} を使う。
  awk -v h="$host" '{ printf "url = \"%s/%s.narinfo\"\noutput = \"/dev/null\"\n", h, $0 }' \
    "$tmp/todo" >"$tmp/urls.conf"

  curl_status=0
  curl -sS -L --parallel --parallel-max 32 -I \
    --connect-timeout 10 --max-time 30 --retry 3 \
    -w '%{http_code} %{url}\n' --config "$tmp/urls.conf" >"$tmp/res" || curl_status=$?

  if [ "$curl_status" -ne 0 ]; then
    printf 'エラー: %s への問い合わせに失敗しました (curl exit %s)。push を中止します\n' \
      "$host" "$curl_status" >&2
    exit 1
  fi

  received="$(wc -l <"$tmp/res" | tr -d ' ')"
  if [ "$received" -ne "$expected" ]; then
    printf 'エラー: %s の応答件数が一致しません (要求 %s / 応答 %s)。push を中止します\n' \
      "$host" "$expected" "$received" >&2
    exit 1
  fi

  # 200 (キャッシュ済み) と 404 (未キャッシュ) 以外は通信・サーバー異常として中断する
  awk 'NF != 2 || ($1 != "200" && $1 != "404")' "$tmp/res" >"$tmp/errors"
  if [ -s "$tmp/errors" ]; then
    printf 'エラー: %s から 200/404 以外の応答が %s 件返りました。push を中止します\n' \
      "$host" "$(wc -l <"$tmp/errors" | tr -d ' ')" >&2
    head -n 5 "$tmp/errors" >&2
    exit 1
  fi

  awk '$1 == "404" { n = split($2, a, "/"); h = a[n]; sub(/\.narinfo$/, "", h); print h }' \
    "$tmp/res" >"$tmp/next"
  mv "$tmp/next" "$tmp/todo"

  printf '  %s を除いて残り %s パス\n' "$host" "$(wc -l <"$tmp/todo" | tr -d ' ')"
done <"$tmp/hosts"

if [ ! -s "$tmp/todo" ]; then
  echo 'どのキャッシュにも無いパスはありませんでした'
  exit 0
fi

grep -F -f "$tmp/todo" "$tmp/closure" >"$tmp/push"
printf '%s パスを %s へ push します\n' "$(wc -l <"$tmp/push" | tr -d ' ')" "$CACHE"

if command -v op >/dev/null 2>&1; then
  op plugin run -- cachix push "$CACHE" <"$tmp/push"
else
  cachix push "$CACHE" <"$tmp/push"
fi
