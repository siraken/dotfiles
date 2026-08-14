# macOS では herdr 本体を Homebrew で入れている (nix/hosts/siraken-mbp/default.nix の
# `brews`) ので `package = null` で nixpkgs 版の導入だけを止め、home-manager には
# `$XDG_CONFIG_HOME/herdr/config.toml` の生成を任せる。それ以外 (WSL など) は
# nixpkgs の herdr をそのまま使うため、両方とも既定のままでよい。
#
# 設定キーの一覧: https://herdr.dev/docs/config-reference/
# 手元のデフォルト値: `herdr --default-config`
{ pkgs, lib, ... }:
let
  # macOS だけ brew 管理。この分岐が `package` と onChange の両方を決める。
  useBrew = pkgs.stdenv.isDarwin;
in
{
  programs.herdr = {
    enable = true;
    package = lib.mkIf useBrew null;

    settings = {
      onboarding = false;

      theme = {
        # tmux (tokyo-night-tmux) / zellij / helix と揃えて TokyoNight。
        name = "tokyo-night";
        auto_switch = false;
      };

      terminal = {
        # tmux (`programs.tmux.shell`) と zellij (`default_shell`) に合わせて bash。
        # atuin / starship / zoxide の bash 統合は profile-core で有効なので、
        # ログインシェル (zsh) と操作感は変わらない。
        default_shell = "${pkgs.bash}/bin/bash";
        new_cwd = "follow";
      };

      update = {
        # 更新は brew / nixpkgs 側で行うので herdr 自身のバージョンチェックは止める。
        # エージェント検出マニフェストの更新だけは残す。
        version_check = false;
        manifest_check = true;
      };

      keys = {
        # herdr のデフォルトのまま。tmux の prefix (`programs.tmux.shortcut = "b"`)
        # と同じキーなので、herdr の中で tmux を動かすと内側までイベントが届かない。
        # nixvim の blink.cmp `<C-b>` (ドキュメント上スクロール) も同様。
        # 入れ子で使うようになったら別のキーに変える。
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

        # `ui.mouse_capture` は既定 (true) のまま。tmux / zellij ではマウスを切って
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

  # home-manager の onChange は `package = null` のとき裸の `herdr` を呼ぶ。activation は
  # `launchctl asuser … sudo -u siraken --set-home` 経由で PATH に /opt/homebrew/bin を
  # 含まないため `command not found` になり、`|| true` に飲まれて reload が黙って飛ぶ。
  # brew の絶対パス指定に差し替える (variable.nix の JAVA_HOME と同じ macOS 前提)。
  # nixpkgs 版を使う環境では `lib.getExe` が store の絶対パスを埋めるので上書き不要。
  xdg.configFile."herdr/config.toml".onChange = lib.mkIf useBrew (
    lib.mkForce ''
      /opt/homebrew/bin/herdr server reload-config || true
    ''
  );
}
