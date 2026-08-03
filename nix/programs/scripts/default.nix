{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "gco" ''
      branch=$(git branch --all | sed 's/^[* ]*//' | fzf)
      if [ -n "$branch" ]; then
        git checkout "$(echo "$branch" | sed 's#remotes/origin/##')"
      fi
    '')

    (pkgs.writeShellScriptBin "gd-select" ''
      ghq list -p | fzf
    '')

    (pkgs.writeShellApplication {
      name = "nix-cache-push";
      runtimeInputs = with pkgs; [
        cachix
        coreutils
        curl
        findutils
        gawk
        gnugrep
        gnused
        nix
      ];
      text = ''
        # システムの closure のうち、上流のバイナリキャッシュがどれも持っていない
        # パスだけを自前の Cachix へ push する。
        #
        # closure 全体は 1174 パス / 12.6 GiB あるが、上流に無いのは 214 パス /
        # 286 MiB だけだった (2026-08-03 実測。mise 105MiB・1password-cli 77MiB・
        # emacs パッケージ 99MiB・このリポジトリ由来の派生など)。丸ごと push すると
        # 無料枠を使い切ってしまうため、narinfo の有無で絞り込んでいる。
        #
        # cachix の認証情報は 1Password Shell Plugin が持っているが、あれはシェル関数
        # なのでスクリプトからは効かない。op があれば op plugin run 経由で呼ぶ。

        CACHE="''${CACHIX_CACHE:-siraken-dotfiles}"
        TARGET="''${1:-/run/current-system}"

        tmp="$(mktemp -d)"
        trap 'rm -rf "$tmp"' EXIT

        nix-store --query --requisites "$TARGET" | sort -u > "$tmp/closure"
        awk -F/ '{ print substr($NF, 1, 32) }' "$tmp/closure" | sort -u > "$tmp/todo"
        printf 'closure: %s パス\n' "$(wc -l < "$tmp/closure" | tr -d ' ')"

        nix config show substituters | tr ' ' '\n' | sed '/^$/d; s:/*$::' | sort -u > "$tmp/hosts"

        # 自前のキャッシュも問い合わせ対象に含める。既に載っているパスが落ちるので、
        # 2 回目以降は差分だけが push 対象になる。
        while read -r host; do
          [ -s "$tmp/todo" ] || break

          # curl の -o は URL ごとの指定なので、設定ファイル側に書く必要がある
          awk -v h="$host" '{ printf "url = \"%s/%s.narinfo\"\noutput = \"/dev/null\"\n", h, $0 }' \
            "$tmp/todo" > "$tmp/urls.conf"
          curl -s --parallel --parallel-max 32 -I \
            -w '%{http_code} %{url_effective}\n' --config "$tmp/urls.conf" > "$tmp/res" || true
          awk '$1 != "200" { n = split($2, a, "/"); h = a[n]; sub(/\.narinfo$/, "", h); print h }' \
            "$tmp/res" > "$tmp/next"
          mv "$tmp/next" "$tmp/todo"

          printf '  %s を除いて残り %s パス\n' "$host" "$(wc -l < "$tmp/todo" | tr -d ' ')"
        done < "$tmp/hosts"

        if [ ! -s "$tmp/todo" ]; then
          echo 'どのキャッシュにも無いパスはありませんでした'
          exit 0
        fi

        grep -F -f "$tmp/todo" "$tmp/closure" > "$tmp/push"
        printf '%s パスを %s へ push します\n' "$(wc -l < "$tmp/push" | tr -d ' ')" "$CACHE"

        if command -v op > /dev/null 2>&1; then
          xargs op plugin run -- cachix push "$CACHE" < "$tmp/push"
        else
          xargs cachix push "$CACHE" < "$tmp/push"
        fi
      '';
    })
  ];
}
