# herdr は TUI 版 (`herdr`) とデスクトップ版 (`herdr-desktop` + `herdr-core`) の
# 2 系統があり、エージェントも設定も共有しない別物。どちらも nixpkgs から入れる。
# `programs.herdr.settings` は TUI 版の `$XDG_CONFIG_HOME/herdr/config.toml`。
# デスクトップ版の設定 (`~/.config/herdr-app`, `~/.config/herdr-core`) は
# ファイル末尾の「デスクトップ版」以降で、TUI 版の設定をデスクトップ版の仕組みに
# 移したもの。
#
# 設定キーの一覧: https://herdr.dev/docs/config-reference/
# 手元のデフォルト値: `herdr --default-config`
# デスクトップ版のガイド: `~/.config/herdr-app/AGENTS.md` (アプリが起動時に書き出す)
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # activation から herdr を呼ぶための絶対パス。activation の PATH には
  # home.packages が載っていないので、ストアのパスを直接埋める。
  herdrBin = lib.getExe config.programs.herdr.package;
  jq = lib.getExe pkgs.jq;

  zsh = lib.getExe config.programs.zsh.package;

  # デスクトップ版のホーム。アプリは XDG_CONFIG_HOME を見ず `~/.config/herdr-app`
  # 固定 (HERDR_APP_HOME で変えられる) なので、xdg.configFile ではなく home.file で置く。
  appHome = ".config/herdr-app";

  tn = import ../../colors/tokyonight.nix;

  # TUI 版の theme.name = "tokyo-night" に当たるもの。デスクトップ版は TokyoNight を
  # 同梱していないので themes/<name>.json を足す。ANSI の割り当ては foot
  # (nix/programs/hyprland/colors.nix) と同じで、前景色だけ Ghostty の TokyoNight に
  # 合わせて white にする。パネルの色はアプリがこの 4 色 + ANSI から導く。
  appTheme = {
    background = tn.ui.bg;
    foreground = tn.white;
    selection = tn.ui.bgSelection;
    cursor = tn.white;
    ansi = [
      tn.darkBlack
      tn.red
      tn.lightGreen
      tn.yellow
      tn.blue
      tn.magenta
      tn.cyan
      tn.ui.fgDark
      tn.black
      tn.red
      tn.lightGreen
      tn.yellow
      tn.blue
      tn.magenta
      tn.cyan
      tn.white
    ];
  };

  # settings.json / keys.json に足す分。アプリ自身がこの 2 つを書き換える
  # (ズームキーや設定画面) ので丸ごと生成も symlink もできない。switch のたびに
  # 既存のファイルへ `. * patch` で深くマージし、ここに無いキーはアプリに任せる。
  appSettingsPatch = {
    # main レイアウトは theme を持たないので settings.json の theme が効く。
    # テーマピッカーで選ぶとレイアウト側の theme が優先される。
    theme = "tokyo-night";

    # ターミナルの文字サイズ (px, ズーム 1 のとき)。既定は 14。main レイアウトは
    # font_size を持たないのでここが効く。パネルまで大きくしたいときは zoom。
    font_size = 16;

    # Settings → Privacy の "Share anonymous usage data"。無いと on。ソースからの
    # ビルドはもともと送らないが、どのビルドでも止まるように明示しておく。
    # false にするとまだ送っていない分も消える。
    telemetry = false;
  };

  # TUI 版のキーは prefix (ctrl+b) 方式だが、デスクトップ版の keys.json は単発の
  # ショートカットだけで prefix の概念がない。TUI 版で埋めた移動系は既定で揃っている
  # ので足さない:
  #   prefix+shift+1..9 (workspace 選択)   → ctrl-1..9      (space.select)
  #   prefix+ctrl+p / n (前後の workspace) → cmd-alt-[ / ]  (space.prev / next)
  #   prefix+shift+a / a (前後の agent)    → cmd-[ / ]      (agent.prev / next)
  # prefix+shift+o (worktree を開く) は、worktree ダイアログが props 付きの
  # openOverlay でしか開けずキーから呼べるコマンドが無いので移せない。
  # スペースのメニューか + メニューの Open worktree から開く。
  appKeysPatch = {
    global = {
      # TUI 版の prefix+u (gitui をポップアップ)。デスクトップ版には浮かせて開く
      # ターミナルが無いので新しいタブで開く。gitui を終了するとタブも閉じる。
      # 起動はシェルを通らないので絶対パスで渡す。
      "cmd-u" = {
        command = "terminal.open";
        args = {
          argv = [ (lib.getExe config.programs.gitui.package) ];
          name = "gitui";
        };
      };
    };
  };
in
{
  programs.herdr = {
    enable = true;

    settings = {
      onboarding = false;

      theme = {
        # zellij / helix と揃えて TokyoNight。
        name = "tokyo-night";
        auto_switch = false;
      };

      terminal = {
        # ログインシェル / zellij (`default_shell`) に合わせて zsh。
        default_shell = lib.getExe config.programs.zsh.package;
        new_cwd = "follow";
      };

      update = {
        # 更新は flake.lock 側で行うので herdr 自身のバージョンチェックは止める。
        # エージェント検出マニフェストの更新だけは残す。
        version_check = false;
        manifest_check = true;
      };

      keys = {
        # herdr のデフォルトのまま。nixvim の blink.cmp `<C-b>` (ドキュメント上
        # スクロール) と同じキーなので、herdr の中の nvim にはこのキーが届かない。
        # 困るようになったら別のキーに変える。
        prefix = "ctrl+b";

        # herdr の workspace は tmux の *session* 相当で、tab は window 相当
        # (https://herdr.dev/docs/concepts/)。「1 リポジトリ = 1 workspace、tab は
        # agent / server / logs / review のような用途で切る」が herdr の想定なので、
        # 操作の主役は tab 切り替えではなく workspace 移動になる。ところが移動系のキーは
        # herdr の既定では軒並み未バインドなので、ここで埋める。
        #
        # tab 側の既定 (prefix+p / prefix+n / prefix+1..9) と対称になるよう、workspace は
        # ctrl と shift を足した形にする。alt は Ghostty の macos-option-as-alt が未設定
        # (レイアウトが ABC) で Option が Alt として届かないため使わない。
        switch_workspace = "prefix+shift+1..9";
        previous_workspace = "prefix+ctrl+p";
        next_workspace = "prefix+ctrl+n";

        # ui.agent_panel_sort = "priority" が作る待ち行列を順に辿る。workspace をまたいで
        # 「次に手を入れるべきエージェント」へ直接飛べるので、複数プロジェクトを並行で
        # 回すときは workspace 移動そのものよりこちらを使う。
        next_agent = "prefix+a";
        previous_agent = "prefix+shift+a";

        # worktree はリポジトリの親 workspace から作り、チェックアウトごとに workspace が
        # 生えてサイドバーで同じリポのグループにまとまる。作成 (prefix+shift+g) だけは
        # 既定でバインド済みなので、開く側を足す。削除は確認ダイアログが出るとはいえ
        # チェックアウト自体を消すので、誤爆を避けて未バインドのままにする。
        open_worktree = "prefix+shift+o";

        command = [
          {
            # programs.gitui をポップアップで開く。alt+ を含む組み合わせは Ghostty の
            # macos-option-as-alt が未設定 = レイアウトが ABC のため false 相当で、
            # Option が Alt として送られない。prefix + 単独キーにしておく。
            key = "prefix+u";
            type = "popup";
            command = "gitui";
            width = "80%";
            height = "80%";
          }
        ];
      };

      ui = {
        # エージェントの状態順に並べる (待ち行列)。space ごとに並べたいなら "spaces"。
        agent_panel_sort = "priority";

        # `ui.prompt_new_tab_name` は既定 (true) のまま。tab は用途で切るものなので、
        # 作成時に名前を聞かれる既定の挙動が正しい。名前を付けなかったときのラベルは
        # 並び順に追従して振り直される連番で、既定名を決める設定キーは無い (0.8.0 時点)。

        # 既定の rows ([["state_icon" "workspace"] ["branch" "git_status"]]) に $num を
        # 足したもの。keys.switch_workspace ("prefix+shift+1..9") で押す番号は
        # サイドバーに描かれないので、config/herdr/plugins/workspace-numbers が
        # workspace.report_metadata で push した値をここで表示する。
        # プラグインは herdr の .plugins.lock への登録が必要で宣言的にできないため、
        # 初回だけ手で叩く:
        #   herdr plugin link ~/dotfiles/config/herdr/plugins/workspace-numbers
        sidebar.spaces.rows = [
          [
            "state_icon"
            "$num"
            "workspace"
          ]
          [
            "branch"
            "git_status"
          ]
        ];

        # `ui.mouse_capture` は既定 (true) のまま。zellij ではマウスを切って
        # いるが、herdr はサイドバー自体がマウス UI で、init.el の xterm-mouse-mode
        # や gitui / bottom もマウスを使うため、ここだけ流儀を合わせない。

        # 既存の config.toml を踏襲して OS の通知サービスへ出す (macOS なら通知センター)。
        toast.delivery = "system";
      };

      experimental = {
        # 日本語入力対策。herdr 側の実装が macOS/Windows 限定なので Linux では
        # no-op になるだけ。プラットフォームで分けずそのまま渡す。prefix 中だけ ASCII 入力へ
        # 切り替え、自前でカーソルを描く TUI エージェントでも変換候補が追従するようにする。
        # 副作用 (vim のノーマルモードで余分なカーソルが出る) を避けるため、
        # 対象は coding-agents で使っているエージェントのみに絞る。
        switch_ascii_input_source_in_prefix = true;
        reveal_hidden_cursor_for_cjk_ime = true;
        cjk_ime_agents = [
          "claude"
          "codex"
          "opencode"
        ];
      };
    };
  };

  # デスクトップ版。Herdr.app は targets.darwin.copyApps で
  # ~/Applications/Home Manager Apps に置かれる。アプリは hc を PATH と既知の場所から
  # 探し、nixpkgs 版はそこに herdr-core のストアパスを足してあるので、herdr-core を
  # 入れるのは `hc` を手元のシェルやエージェントからも叩けるようにするため。
  # ソースからのビルドなのでアプリ内の自動更新は効かず、設定画面にも nixpkgs の
  # パッチで「Managed by nix」と出る。更新は flake.lock 側で行う。
  home.packages = [
    pkgs.herdr-desktop
    pkgs.herdr-core
  ];

  # TUI 版の terminal.default_shell に当たるもの。デスクトップ版のターミナルは
  # herdr-core が起こすので、シェルはアプリではなく core の設定で決まる。指定しないと
  # ログインシェル (macOS では Apple の /bin/zsh) になる。
  # core が起動時に読むので、変えたら `hc server restart` (ターミナルは残る)。
  home.file.".config/herdr-core/config.toml".source =
    (pkgs.formats.toml { }).generate "herdr-core.toml"
      {
        shell = [ zsh ];
      };

  # アプリは themes/ の自作テーマを書き換えない (同梱テーマの更新だけ) ので symlink で置ける。
  home.file."${appHome}/themes/tokyo-night.json".text = builtins.toJSON appTheme;

  # TUI 版から移していないもの:
  # - onboarding = false: ウェルカム画面を消す設定が無い (一度閉じれば出ない)。
  # - update.*: ソースからのビルドなのでアプリも core も自動更新しない。
  # - terminal.new_cwd = "follow": デスクトップ版は既定でフォーカス中のペインの
  #   フォルダで開く。
  # - ui.agent_panel_sort = "priority": agents パネルの既定の並び順。
  # - ui.sidebar.spaces.rows の $num: スペース一覧が既定で番号を描く。
  # - ui.toast.delivery = "system": 通知はアプリ内のトーストで出る。OS の通知センターへ
  #   出すにはレイアウトを複製して toast mod を差し替える必要がある。
  # - experimental.*: 日本語入力は macOS のネイティブのテキスト入力を通るので不要。
  #   prefix も無いので ASCII 切り替えの対象が無い。
  home.activation.herdrAppSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    herdrAppMerge() {
      file=$1 patch=$2
      tmp=$(mktemp "$file.XXXXXX")
      if ! ${jq} --argjson patch "$patch" '. * $patch' "$file" > "$tmp"; then
        warnEcho "herdr-app: $file is not valid JSON, leaving it alone"
      elif ! cmp -s "$tmp" "$file"; then
        $DRY_RUN_CMD mv "$tmp" "$file"
      fi
      rm -f "$tmp"
    }

    appHome="$HOME/${appHome}"
    $DRY_RUN_CMD mkdir -p "$appHome"

    # settings.json は無ければ空から作ってよい。アプリは足りない項目を既定で補う。
    [ -f "$appHome/settings.json" ] || $DRY_RUN_CMD sh -c "echo '{}' > '$appHome/settings.json'"
    [ -f "$appHome/settings.json" ] && \
      herdrAppMerge "$appHome/settings.json" ${lib.escapeShellArg (builtins.toJSON appSettingsPatch)}

    # keys.json は全ショートカットの一覧で、既定のキーとはマージされない。無いところに
    # ここの分だけ書くと既定のキーが全部消えるので、アプリが一度起動して既定を書き出して
    # から次の switch で足す。手を入れたファイルはアプリの更新で新しい既定キーを
    # 受け取らなくなるので、増えたキーは `herdr-app commands` と AGENTS.md を見て足す。
    if [ -f "$appHome/keys.json" ]; then
      herdrAppMerge "$appHome/keys.json" ${lib.escapeShellArg (builtins.toJSON appKeysPatch)}
    else
      noteEcho "herdr-app: no keys.json yet; start Herdr once, then switch again to add key bindings"
    fi
  '';

  # TUI 版とデスクトップ版はそれぞれエージェント用のスキルを同梱しているが、配置までは
  # 面倒を見ない。置かないとエージェントに毎回使い方を教えることになるうえ、片方しか
  # 無いと、もう片方の中で動くエージェントが手元のスキルの前提 (TUI 版の `herdr` なら
  # HERDR_ENV=1) を満たせず「Herdr の外にいる」と判断して止まる。
  # - herdr: TUI 版。`herdr --skill` で取り出す。
  # - herdr-core: デスクトップ版。パッケージの share/skills に入っている。中身は
  #   「$HC_TERMINAL_ID があれば hc を使い、`hc --skill` / `herdr-app --skill` を読め」
  #   という入口だけで、本文はバイナリ側にあるのでバージョンがずれない。
  #
  # 中身は入っている herdr のバージョンに追従するため、リポジトリにコミットすると
  # herdr を更新した時点でスキルだけ古くなる。switch のたびに入っているものから置き直す。
  #
  # 配布先は apm (~/.apm/apm.yml) が materialize するのと同じランタイムのディレクトリ。
  # apm 自身の依存には載せない。apm が配るのは公開パッケージで、こちらは手元のバイナリ
  # から生成する派生物なので、載せると herdr 更新のたびに再生成と `apm install` の
  # 2 手が要る。apm は自分の管理外のファイルを既定では上書きしないので共存できる。
  home.activation.herdrAgentSkill = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    herdrInstallSkill() {
      name=$1 src=$2
      for runtime in \
        "$HOME/.claude/skills" \
        "$HOME/.codex/skills" \
        "$HOME/.gemini/skills" \
        "$HOME/.config/opencode/skills"; do
        # そのエージェントを入れていないホストに skills ディレクトリを作らない
        [ -d "$runtime" ] || continue
        $DRY_RUN_CMD mkdir -p "$runtime/$name"
        # ストアのファイルは読み取り専用なので、モードは揃えて置く
        $DRY_RUN_CMD install -m 0644 "$src" "$runtime/$name/SKILL.md"
      done
    }

    if [ -x ${herdrBin} ]; then
      skill=$(mktemp)
      if ${herdrBin} --skill > "$skill" 2>/dev/null && [ -s "$skill" ]; then
        herdrInstallSkill herdr "$skill"
      fi
      rm -f "$skill"
    fi

    coreSkill=${pkgs.herdr-core}/share/skills/herdr-core/herdr-core/SKILL.md
    if [ -s "$coreSkill" ]; then
      herdrInstallSkill herdr-core "$coreSkill"
    else
      warnEcho "herdr-core: $coreSkill not found; the package layout may have changed"
    fi
  '';
}
