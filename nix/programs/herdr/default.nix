# herdr は TUI 版 (`herdr`) とデスクトップ版 (`herdr-desktop` + `herdr-core`) の
# 2 系統があり、エージェントも設定も共有しない別物。どちらも nixpkgs から入れる。
# ここで宣言する `settings` は TUI 版の `$XDG_CONFIG_HOME/herdr/config.toml` だけで、
# デスクトップ版の設定 (`~/.config/herdr-app`) はまだ管理しない。
#
# 設定キーの一覧: https://herdr.dev/docs/config-reference/
# 手元のデフォルト値: `herdr --default-config`
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

  # herdr はエージェント用のスキルを SKILL.md 形式でバイナリに同梱していて
  # `herdr --skill` で取り出せるが、配置までは面倒を見ない。置かないとエージェントに
  # 毎回使い方を教えることになる。
  #
  # 中身は入っている herdr のバージョンに追従するため、リポジトリにコミットすると
  # herdr を更新した時点でスキルだけ古くなる。switch のたびにバイナリから吐き直す。
  #
  # 配布先は apm (~/.apm/apm.yml) が materialize するのと同じランタイムのディレクトリ。
  # apm 自身の依存には載せない。apm が配るのは公開パッケージで、こちらは手元のバイナリ
  # から生成する派生物なので、載せると herdr 更新のたびに再生成と `apm install` の
  # 2 手が要る。apm は自分の管理外のファイルを既定では上書きしないので共存できる。
  home.activation.herdrAgentSkill = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x ${herdrBin} ]; then
      skill=$(mktemp)
      if ${herdrBin} --skill > "$skill" 2>/dev/null && [ -s "$skill" ]; then
        for runtime in \
          "$HOME/.claude/skills" \
          "$HOME/.codex/skills" \
          "$HOME/.gemini/skills" \
          "$HOME/.config/opencode/skills"; do
          # そのエージェントを入れていないホストに skills ディレクトリを作らない
          [ -d "$runtime" ] || continue
          $DRY_RUN_CMD mkdir -p "$runtime/herdr"
          $DRY_RUN_CMD cp -f "$skill" "$runtime/herdr/SKILL.md"
        done
      fi
      rm -f "$skill"
    fi
  '';
}
