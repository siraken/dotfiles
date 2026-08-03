# siraken/dotfiles 改善候補まとめ

> 一時ファイル。2026-07-28 時点の調査結果。実測して裏を取った内容のみ記載。

## 総評

構造（`nix/programs/` 単位のモジュール化、`mkRepoLink` による out-of-store symlink、treefmt+pre-commit）は既にかなり良く整備されている。改善余地は **①CI が実機の設定を検証していない ②ホストプロファイルのコピペ重複 ③キャッシュを取り逃しているビルド** の3点に集中している。

## 進捗

| # | 項目 | 状態 |
| --- | --- | --- |
| 1 | `--impure` による CI と実機の乖離 | **対応済み** (2026-07-28) |
| 2 | CI が darwin を検証しない / updater 直 push | **対応済み**（実ビルドは保留、下記）(2026-07-29) |
| 3 | Nix 管理外の暗黙依存（sfw / 相対 PATH / TERM） | 未着手 |
| 4 | mise overrideAttrs のキャッシュ捨て | **対応済み** (2026-07-28) |
| 5 | fish 補完 114 派生 | **対応済み** (2026-07-28) |
| 6 | `man.generateCaches` が mbp だけ | **対応済み** (2026-07-28) |
| 7 | 全ホスト共通パッケージ集合 12.6 GiB | 未着手 |
| 8 | 自前バイナリキャッシュ無し | 未着手 |
| 9 | flake input の重複・未使用 | 未着手 |
| 10 | Determinate Nix と nix-darwin の二重管理 | 未着手 |
| 11 | ホスト定義の大量重複 | **対応済み** (2026-07-28) |
| 12 | `import foo.nix { }` 関数パターン | 未着手 |
| 13 | デッドコード | 未着手 |
| 14 | ワークアラウンドの棚卸し機構 | 未着手 |
| 15 | `writeShellScriptBin` の runtimeInputs | 未着手 |
| 16 | 宣言的管理の外にあるもの | 未着手 |
| 17 | nixvim treesitter の 323 ローカル派生 | **対応済み** (2026-07-28) |
| 18 | home-manager manpage のローカルビルド | 未着手（追加発見） |

______________________________________________________________________

## P0: 安定性に直結（優先度最高）

### 1. `--impure` によって「CI が検証する設定」と「実機に入る設定」が別物 — 対応済み

`nix/programs/git/default.nix:21-23` が `~/dotfiles/secrets.json` を eval 時に読むため全コマンドに `--impure` が必要になっている。実測で確認した挙動:

```
pure   eval → /nix/store/y6x4814cqya8m09pf8k20sgf823aqbfk-darwin-system-...drv
impure eval → /nix/store/8k1j3h3fwbp9nkj9j8rla60h6zldwszs-darwin-system-...drv
```

**pure eval はエラーにならず、静かに `gitClients = []` の別派生を作る**（secrets.json には 2 エントリある）。つまり CI の `nix flake check --impure`（secrets.json 不在）が通っても、実機に入る派生は検証されていない。しかも失敗シグナルが出ないのが一番危険。

対策（いずれか）:

- **推奨**: `includeIf` を eval 時読み取りから外す。git は存在しない include パスを黙って無視するので、`~/.config/git.custom/clients.gitconfig` 1枚を無条件 include し、その中に `includeIf` を書く運用にすれば `--impure` を完全に廃止できる
- コメントアウト済みの `dotfiles-private` private flake input を復活させる（`flake.nix:64-66`）
- 当面残すなら `lib.warnIf (!builtins.pathExists secretsPath) "secrets.json not found"` を入れて静かな分岐を可視化し、CI では `secrets.example.json` を配置して評価対象を揃える

**対応**: 推奨案（eval 時読み取りの廃止）を採用。

- `nix/programs/git/default.nix` の `builtins.pathExists` / `builtins.readFile` を削除し、`~/.config/git.custom/clients.gitconfig` を無条件 include するだけにした（git は存在しない include パスを黙って無視する）
- そのファイルは home-manager の activation script が `secrets.json` から毎 switch 時に再生成する（`pkgs.writeShellApplication` + `jq`、`runtimeInputs` 指定済み）。データの置き場所と編集フローは従来どおり `secrets.json` のまま
- `--impure` を `flake.nix` の apps、`.github/workflows/{ci,updater}.yaml`、`README.md`、`AGENTS.md` から削除。リポジトリ内に残る `--impure` は経緯を説明するコメント1箇所のみ
- `AGENTS.md` に「eval 時に flake 外のパスを読まない」ルールを明文化

**検証**:

| 検証項目 | 結果 |
| --- | --- |
| pure eval と impure eval の派生一致 | `zrgmfr2fl9lc0hv7awin8xij8bhgxx4b` で**完全一致**（対応前は不一致） |
| 5プロファイル全ての pure eval | 全て成功 |
| macOS 両システムの pure ビルド | exit 0（`writeShellApplication` の shellcheck も通過） |
| `darwin-rebuild build --flake .#siraken-mbp`（`--impure` なし） | exit 0、`result` が検証済み派生と一致 |
| 生成される `clients.gitconfig` | 従来と同じ `includeIf` 2ブロックを出力、`git config --file` でパース可能 |
| `~/.config/git/config` の include 順 | 共有 config → clients.gitconfig（クライアント設定が後勝ち、従来どおり） |

### 2. CI が darwin を一度もビルドしていないのに、updater が main へ直 push

実測（`nix eval .#checks.x86_64-linux`）:

```
[ "pre-commit" "treefmt" ]
```

- `checks.aarch64-darwin.{siraken-mbp,siraken-macmini}` は定義済みだが、`ci.yaml` の runner は `ubuntu-latest` なので**実行されない**
- `homeConfigurations.wsl-ubuntu` は checks に無いため `activationPackage` も未検証
- `updater.yaml` は 6時間ごと（**1日4回**）に `nix flake update` → Linux 限定 check → `git push` で main 直更新。darwin を壊す lock 更新は素通りし、手元で `darwin-rebuild` した時に初めて発覚する

対策:

- `macos-15`（arm64）ジョブを追加。**このリポジトリは public なので macOS arm64 runner は無料枠で使える**（API で確認済み）
- `checks.x86_64-linux` に `wsl-ubuntu.activationPackage` / `wsl-nixos`,`nixos-vm` の `system.build.toplevel` を追加して実際にビルドさせる
- updater を PR ベース（`peter-evans/create-pull-request`）に変更、または少なくとも日次へ。`nixpkgs-unstable` チャンネル自体は週数回しか進まないので 1日4回はほぼ空振り

**対応**（2026-07-29）:

- `checks.<system>.eval-all` を追加。5プロファイル全ての `drvPath` を評価して1つの text ファイルに書くだけの派生で、**評価は強制されるがプロファイルはビルドされない**（`unsafeDiscardStringContext` で context を捨てているため）。実測でビルド対象は 1 派生・0.7 秒。これで CI が macOS 構成を含む全プロファイルの評価崩れを検出する
- updater を **PR ベース＋日次（06:00 JST）** に変更。`flake-update` ブランチを使い回し、既存 PR があれば本文を更新する
- `.github/workflows/*` は `actionlint`（shellcheck 込み）で検証済み

**macOS runner での実ビルドは見送り**（当初案からの変更）:

GitHub hosted runner は ubuntu・macOS とも **ディスク 14 GB**（公式ドキュメントで確認）に対し、システムクロージャは実測 **12.4 GiB**。1プロファイルでも収まらないため、hosted runner での実ビルドは成立しない。`checks.aarch64-darwin.{siraken-mbp,siraken-macmini}` は従来どおり残してあるので、手元の `nix flake check` では実ビルドされる。CI に載せるには先に **P1-7（パッケージのロール分割）でクロージャを縮める**か、\*\*P1-8（自前キャッシュ）\*\*が必要。

もう一点、当初案では PR の CI で検証する想定だったが、`GITHUB_TOKEN` で作成した PR は**ワークフローを起動しない**（GitHub 公式ドキュメントで確認）。そのため updater ジョブ内で `nix flake check` を実行し、その結果を PR 本文に明記する形にした。マージ後に main への push で CI が再度走る。

### 3. Nix 管理外の暗黙依存が壊れやすい — 対応済み

| 箇所 | 問題 |
| --- | --- |
| `nix/modules/aliases.nix:53-59` | `npm`/`pnpm`/`bun` などを `sfw <cmd>` にエイリアスしているが、`sfw` は Nix で入れていない（実機では `/usr/local/bin/sfw` = 手動インストール）。新規マシン・WSL では **npm 系が全部壊れる** |
| `nix/modules/path.nix:6` | PATH に相対パス `"bin"` が入っている。CWD 相対の `./bin` が PATH に入るのは信頼できないリポジトリで危険 |
| `nix/modules/variable.nix:5` | `TERM = "xterm-256color"` を全シェルで固定。Ghostty/kitty/tmux が渡す TERM を上書きし、truecolor や機能検出を落とす（`tmux.terminal` も `screen-256color` で古い） |
| `nix/modules/{path,variable}.nix` | homebrew 前提のパス（`/opt/homebrew/*`、`JAVA_HOME=/opt/homebrew/opt/openjdk@21`）や `SSH_AUTH_SOCK=~/.1password/agent.sock` を **WSL/NixOS ホストにも無条件で適用**している（`import` 関数形式で `pkgs`/`lib` を受け取らないため分岐できない） |

`sfw` は Nix で提供するか、`if type -q sfw` の条件付きエイリアスに落とすのが安全。

**対応**（2026-08-03）:

- `sfw` エイリアスを `home.shellAliases` から外し、bash / zsh / fish それぞれの条件付きエイリアス側へ移した。`sfw` が無い環境ではエイリアスが定義されず素のコマンドが使える。既存の `type X >/dev/null` は標準エラーを潰していなかったので `2>&1` を足した（`sfw` が無いマシンでこそ出るノイズだったため）。zsh には条件付きエイリアスの置き場が無かったので `config/zsh/alias.zsh` を追加
- PATH から相対パス `"bin"` を削除
- `TERM` の固定をやめた。端末エミュレータや tmux が渡す値をそのまま使う
- `path.nix` / `variable.nix` を `{ lib, pkgs }` を受け取る形にして、homebrew の prefix・`$HOME/Library/*`・`JAVA_HOME`・`SSH_AUTH_SOCK` を `lib.optionals pkgs.stdenv.isDarwin` で macOS 限定にした。実測で wsl-ubuntu の `sessionPath` は 20 → 13 件になり macOS 固有の項目が消え、`TERM`/`SSH_AUTH_SOCK`/`JAVA_HOME` も未定義になることを確認

残件: `path.nix` の `$COMPOSER_HOME/vendor/bin` は `COMPOSER_HOME` を定義する `variable.nix` が `profile-full` にしか無いため、`profile-core` だけの `nixos-vm` では `/vendor/bin` に展開される（実害は無いが不正確）。

______________________________________________________________________

## P1: 速度（キャッシュを効かせる）

### 4. `mise` の overrideAttrs がバイナリキャッシュを捨てている（実測確認）— 対応済み

`nix/hosts/siraken-mbp/default.nix:180-184` の `doCheck = false` は派生ハッシュを変えるため、キャッシュヒットしない:

```
override なし: /nix/store/51z26...-mise-2026.7.10 → cache.nixos.org narinfo 200 OK
override あり: /nix/store/7m0rn...-mise-2026.7.10 → 404 NG（毎回 Rust をフルビルド）
```

コメントは `mise 2026.6.11` 時点の話で、現在の 2026.7.10 は**上流キャッシュに存在する**。override を外して `nix build` を試す価値が高い（macmini 側には元々この override が無いのも整合性の問題）。

**対応**: `nix/hosts/siraken-mbp/default.nix` から override を削除。`nix build` で `51z26...-mise-2026.7.10` がキャッシュから取得できることを実測確認済み（30.7 MiB ダウンロード、ソースビルド無し）。

### 5. fish 補完の自動生成で 114 個のローカル派生 — 対応済み

`programs.fish.generateCompletions` は home-manager 既定 `true` で、`home.packages` の各パッケージごとに man→fish 補完の派生を作る。現行クロージャで **114 個**（合計 0.9 MiB / 全 1542 パス）。容量は小さいが、これらは**キャッシュに存在し得ないローカルビルド**なので、パッケージが動くたびに毎回走る。fish の補完をそこまで使っていなければ `generateCompletions = false`、または必要なものだけに絞るとリビルドが目に見えて軽くなる。

**対応**: `nix/programs/fish/default.nix` で `generateCompletions = false`。派生数の実測変化は siraken-mbp 8248→8134、macmini 8243→8129、wsl-ubuntu 9051→8930（差分はすべて `*-fish-completions`、追加された派生はゼロ）。

### 6. `programs.man.generateCaches = false` が mbp だけ — 対応済み

`nix/hosts/siraken-mbp/home.nix:74` にはあるが macmini / wsl-\* には無く、macmini は man キャッシュ生成（重い）を毎回払っている。共通プロファイルへ移すべき設定。

**対応**: `nix/modules/home/profile-core.nix` に移動し、全プロファイルへ適用。

### 7. パッケージ集合が全ホスト共通 → クロージャ 12.6 GiB

`nix/modules/nixpkgs.nix` を4プロファイルすべてが無条件で読み込んでいる。実測:

- `darwin-system` クロージャ: **12.6 GiB** / `/nix/store` 全体 **53 GB**
- 自己サイズ上位: ansible 510 MB / codex 461 MB / apple-sdk 15.5 459 MB + 14.4 346 MB（2世代同居）/ emacs-nox 359 MB / **zulu-ca-jdk-21 341 MB** / zed 326 MB

JDK は `gradle`/`maven`/`sbt`/`scala` 経由の zulu21 + homebrew `openjdk@21`（JAVA_HOME）+ cask `zulu@17` で**実質3系統**ある。`base` / `dev` / `heavy`（JVM系・ansible・emacs）でロール分割し、たまにしか使わないものは `nix shell nixpkgs#…` や devenv に降ろすのが効く。

あわせて `nix.optimise.automatic = true`（現状 `auto-optimise-store = false`）でストア重複排除、gc の `--delete-older-than 7d` の見直しも。

### 8. 自前バイナリキャッシュが無い（「ビルドせずキャッシュ」の本命）

上流に無い派生（fish補完、nixvim ラッパー、override 済みパッケージ、sketchybar スクリプト等）は必ずローカルビルドになる。**public リポジトリなので Cachix 無料枠 / FlakeHub Cache が使える**。macOS runner で `.#darwinConfigurations.siraken-mbp.system` をビルドして push すれば、手元の `darwin-rebuild switch` はダウンロードのみになる（closure 全体ではなく「上流に無いパスだけ」を push すれば容量は小さく収まる）。

補足: eval 自体は暖機後 **約8秒**（pure/impure ともほぼ同じ）でボトルネックではない。効くのは上記のビルド側。なお `cache.numtide.com` の鍵 `niks3.numtide.com-1:…` は narinfo の Sig と一致しており**正しい**ことを確認済み。

### 9. flake input の重複と未使用 input

`flake.lock` は 31 ノード / **nixpkgs 実体が5系統**（`nixpkgs`, `nixpkgs_2`, `nixpkgs_3`, `nixpkgs-docs`, `nixpkgs-for-bootstrap`）。

- `nix-on-droid` は `nixOnDroidConfigurations` がコメントアウト（`flake.nix:202-206`）なのに input として残り、古い `nixpkgs_3`(1781607440) を引き込み lock churn を発生させている → 削除か復活の判断を
- `op-shell-plugins` は `follows` 無し。`llm-agents` は **意図的に follows しない方が正しい**（自前キャッシュ `cache.numtide.com` のヒットを維持するため）ので、ここは一律 follows を付けないよう注意

### 10. Determinate Nix と nix-darwin の二重管理

`/etc/nix/{nix.conf,nix.custom.conf}.before-nix-darwin` が残り、LaunchDaemons には `org.nixos.nix-daemon.plist` と `systems.determinate.nix-installer.nix-hook.plist` が同居、`nix --version` は素の `nix (Nix) 2.34.8`（nix-darwin 管理の nix）。`nix/modules/nix-caches.nix` の「Determinate の設定が上書きされる」というコメントはこの状態の症状。

実際に生成された nix.conf にも重複が出ている:

```
substituters = …cache.nixos.org/ … cache.nixos.org/   # 2回
trusted-users = root siraken root                      # 重複
```

どちらか一方に寄せるべき（Determinate 公式 darwin モジュール + `nix.enable = false` に寄せると lazy-trees 等の高速化も使える / あるいは Determinate を完全撤去して nix-darwin に統一）。substituters は `extra-substituters` にして既定値の再宣言をやめると重複も消える。

______________________________________________________________________

## P1 追加: 着手順3 の作業中に判明した項目

### 17. nixvim の treesitter が 323 個のローカル派生を生んでいる（最大の残ビルド要因）— 対応済み

着手順3 の適用後に `nix build .#darwinConfigurations.siraken-mbp.system --dry-run` を取ると:

```
these 348 derivations will be built:
```

内訳（実測）:

| 派生 | 件数 |
| --- | --- |
| `vimplugin-nvim-treesitter-queries-*` | **323** |
| home-manager / nixvim / system-path などの生成物 | 25 |

`nix/programs/vim/treesitter/default.nix` は `plugins.treesitter.enable = true` だけで grammar を絞っていないため、nixvim 既定の全 grammar が対象になり、言語ごとの query 展開がすべてローカルビルドになる（バイナリキャッシュには存在しない）。`flake.lock` の nixvim/nixpkgs が動くたびに 323 件のビルドが走る。

対策: `plugins.treesitter.grammarPackages` を実際に使う言語へ絞る。ただし絞った言語以外のハイライトが無くなる**挙動変更**なので、対象言語の合意が必要。

**対応**: `nix/programs/vim/treesitter/default.nix` で `grammarPackages` を 52 言語に限定。選定根拠は `../lsp` の LSP サーバー（lua_ls / ts_ls / gopls / pyright / ruby_lsp / jsonls / yamlls / html / cssls / tailwindcss / dockerls / nil_ls）、`../lang` のプラグイン（rustaceanvim / crates / jdtls / venv-selector / render-markdown）、alias・PATH から読み取れる用途（PHP+Laravel / Flutter+Dart / Scala）、およびこのリポジトリ自身のファイル形式。全 grammar 名は `builtGrammars` の実在名と突き合わせ済み（`jsonc` と `tailwindcss` は grammar が存在しないため除外）。

実測（siraken-mbp のシステム派生）:

| | 前 | 後 |
| --- | --- | --- |
| `nvim-treesitter-queries-*` 派生 | 323 | **56** |
| クロージャ内の全派生数 | 8134 | **7086** |
| 追加された派生 | — | **0** |

言語を戻すのは同ファイルへの1行追記で済む。

### 18. home-manager のマニュアル（manpage）がローカルビルドされている

同じ dry-run に `home-configuration-reference-manpage` が含まれている。`manual.manpages.enable = false` にすれば削減できる（代償は `man home-configuration.nix` が引けなくなること。オプション検索はオンラインの HM Options か `nix repl` で代替可能）。

______________________________________________________________________

## P2: 保守性・拡張性

### 11. ホスト定義の大量重複 — 対応済み

- `nix/hosts/*/default.nix` 4本が nix-index / overlay / home-manager 配線をほぼ完全にコピペ（mbp と macmini は homebrew リスト以外ほぼ同一、nixos-vm と wsl-nixos も同様）
- `*/home.nix` 4本が programs import 30〜37行 + `home.*` ブロックをコピペ

**これが実際にドリフトを生んでいる**: macmini に `generateCaches=false` が無い / mise override が mbp だけ / difftastic が wsl-ubuntu でコメントアウト / fish が wsl-nixos で無効。

`nix/lib/mk-darwin-host.nix`・`mk-nixos-host.nix` と `nix/modules/home/profile-common.nix`（program bundle をロール別に定義）へ抽出し、ホスト固有は差分のみにするのが最も効果的なリファクタ。

**対応**: 以下を新規作成し、5プロファイルすべてを載せ替えた。

| ファイル | 役割 |
| --- | --- |
| `nix/lib/overlays.nix` | 全ホスト共通の overlay（llm-agents）。4箇所のコピペを1箇所に |
| `nix/lib/mk-darwin-host.nix` | nix-darwin ホストビルダー（nix-index / overlay / home-manager 配線 / user レコード） |
| `nix/lib/mk-nixos-host.nix` | NixOS ホストビルダー（同上 + nix-caches） |
| `nix/modules/home/profile-core.nix` | 全5プロファイルの共通部分（プログラム22個の積集合 + `home.*` 設定 + `man.generateCaches`） |
| `nix/modules/home/profile-full.nix` | 常用マシン向け（core + coding-agents / emacs / husky / nano / neovide / 1Password / `sessionVariables`） |
| `nix/modules/home/profile-darwin.nix` | macOS のみ（difftastic / ghostty / kitty / wezterm / zed / aerospace / jankyborders） |

行数の実測: ホスト側 10ファイルで **-428行 / +38行**、共通モジュール 6ファイルで **+239行**（説明コメント込み）。差し引き約150行減で、重複していた配線が6ファイルに集約された。ホストに残るのは homebrew リスト・host 固有サービス・host 固有プログラム（fastfetch / fish / spotify-player など）だけ。

`imports` はモジュール引数（`pkgs`）に依存させると評価順の問題を招くため、プラットフォーム分岐は `lib.optionals` ではなく `profile-darwin.nix` の明示 import に分けている。

**検証**: リファクタ前後の派生を突き合わせ、パッケージ集合が同一であることを確認済み。

| プロファイル | 派生数 (前 → 後) | 名前レベルの差分 |
| --- | --- | --- |
| siraken-mbp | 8248 → 8134 | `*-fish-completions` 114件のみ（追加ゼロ） |
| siraken-macmini | 8243 → 8129 | `*-fish-completions` 114件のみ（追加ゼロ） |
| wsl-nixos | 9642 → 9642 | **差分ゼロ** |
| nixos-vm | 9993 → 9993 | **差分ゼロ** |
| wsl-ubuntu | 9051 → 8930 | `*-fish-completions` 121件のみ（追加ゼロ） |

リファクタ単体（着手順3の変更を除いた差分）では、siraken-mbp のシステム派生の違いは `home-manager-path` の `chosenOutputs` の**並び順のみ**（113要素が集合として完全一致）だった。`ignoreCollisions = false` なので、順序変更でファイル衝突の勝者が黙って入れ替わることはない（衝突すればビルドが失敗する）。

さらに `nix build .#checks.aarch64-darwin.{siraken-mbp,siraken-macmini,treefmt,pre-commit}` を実行し、**両 macOS システムの実ビルドが成功**（exit 0）することを確認済み。treefmt / pre-commit も通っている。

### 12. `import ../../modules/foo.nix { }` 関数パターンをモジュール化

`variable.nix` / `path.nix` / `aliases.nix` / `nixpkgs.nix` / `shells.nix` が引数 `{ }` や `{ pkgs }` の素の関数なので、`lib.mkIf pkgs.stdenv.isDarwin` 相当の分岐ができず、P0-3 の「Linux に homebrew パス」問題を構造的に生んでいる。普通の home-manager モジュール（`{ lib, pkgs, ... }`）に変換すれば分岐もオプション化も自然に書ける。

### 13. デッドコード

| 対象 | 状態 |
| --- | --- |
| `nix/home/minimal/home.nix:26` | 存在しない `../../modules/symlinks.nix` を import → **壊れている**。flake に未登録なので CI でも検出されない |
| `nix/programs/vscode/` (381行) | 全ホストでコメントアウト |
| `nix/programs/twitch-tui/` | どのプロファイルからも import されていない（README/AGENTS.md には記載あり） |
| `nix/hosts/pixel10/` | `flake.nix` でコメントアウト |
| `nix/programs/herdr/` | 空ディレクトリ（git 未追跡の残骸） |
| `.github/scripts/` | 空ディレクトリ |
| devShell の `nixpkgs-fmt` | `nixfmt` と併存。nixpkgs-fmt は非推奨 |

削除するか、flake に登録して CI に載せるかを決めるべき（`__template__` は意図的な雛形なのでそのままで OK）。

### 14. ワークアラウンドの棚卸し機構が無い

`spotify-player`（cctools リンカクラッシュ）、`minikube`、`sbcl`、`fish`(wsl-nixos, fisher hash)、`mise` の4〜5箇所が「無効化コメント」で放置され、P1-4 のように**既に不要になっていても気付けない**。無効化理由と再検証日を1ファイルに集約するか、週次で「無効化中のものをビルドしてみる」CI ジョブを置くと自動で回収できる。

### 15. `writeShellScriptBin` の runtimeInputs 未指定

`nix/programs/scripts/default.nix` の `gco` は `git`/`fzf`/`sed`、`gd-select` は `ghq`/`fzf` を PATH 依存で呼んでいる。sketchybar プラグイン（`writeShellScript` + `readFile`）も `pmset`/`grep`/`cut` 等を PATH 解決。`pkgs.writeShellApplication { runtimeInputs = [...] }` にすると PATH 汚染や欠損に強くなり、`shellcheck` も自動で通る。

### 16. 宣言的管理の外にあるもの

`installers/{composer,pecl,python,luarocks}.sh` と `windows/` は手動実行の命令的スクリプトで、いつ誰が適用したか追跡できない。mise / devenv 側へ寄せるか、「意図的に Nix 管理外」と README に明記して線引きするのが良い。`wsl-nixos/configuration.nix:52` の `initialPassword = "nixos"` も平文コミット扱いなので一言注意を書いておく価値がある。

______________________________________________________________________

## 着手順

### 初回提案（2026-07-28）

1. ~~**`--impure` 撤廃**（P0-1）~~ → 未着手
1. ~~**CI に macOS runner + 実ビルド checks を追加、updater を PR 化・日次化**（P0-2）~~ → 未着手
1. ~~**mise override 削除 / fish generateCompletions / generateCaches を共通化**（P1-4,5,6）~~ → **完了**
1. ~~**Cachix or FlakeHub Cache 導入**（P1-8）~~ → 未着手
1. ~~**`mkDarwinHost` + `profile-common` 抽出**（P2-11）~~ → **完了**
1. デッドコード掃除、モジュール化、`sfw`/PATH/TERM の修正 → 未着手

### 改訂版（3・5 完了後）

1. **P1-17 treesitter の grammar 絞り込み** — 残ビルド 348 件のうち 323 件がここ。使用言語の合意だけ取れれば即効。要判断（挙動変更）
1. **P0-1 `--impure` 撤廃** — CI を意味あるものにする前提条件。11 の共通プロファイル化が済んだので、`git` モジュールだけ直せば済む状態になった
1. **P0-2 CI 強化**（macOS runner + 実ビルド checks + updater の PR 化） — 1 の後に入れると「実機と同じ設定」を検証できる
1. **P1-8 自前バイナリキャッシュ** — 3 の CI 基盤に push を足す形。17 を先にやっておくと push 対象が小さくなる
1. **P0-3 暗黙依存の解消**（`sfw` / 相対 PATH `bin` / `TERM`）＋ **P2-12 モジュール化** — 12 を先にやると 3 の分岐が自然に書ける
1. **P2-13 デッドコード掃除**（`minimal` の壊れた import、`vscode`、`twitch-tui`、`pixel10`、空ディレクトリ）
1. **P1-7 パッケージのロール分割** — 11 の profile 構造ができたので、`profile-heavy.nix`（JVM / ansible / emacs）を切り出すだけで済む
1. 残り（P1-9 input 整理、P1-10 Determinate 一本化、P1-18 manpage、P2-14 ワークアラウンド棚卸し、P2-15 runtimeInputs、P2-16 管理外スクリプト）
