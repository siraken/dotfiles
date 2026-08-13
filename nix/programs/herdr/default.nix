# herdr 本体は Homebrew 管理 (nix/hosts/siraken-mbp/default.nix の `brews`)。
# `package = null` で nixpkgs 版の導入だけを止め、home-manager には
# `$XDG_CONFIG_HOME/herdr/config.toml` の生成を任せる。設定が変わると
# activation で `herdr server reload-config` が走る (下の onChange)。
#
# 設定キーの一覧: https://herdr.dev/docs/config-reference/
# 手元のデフォルト値: `herdr --default-config`
{ pkgs, lib, ... }:
{
  programs.herdr = {
    enable = true;
    package = null;

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
        # 更新は brew 側で行うので herdr 自身のバージョンチェックは止める。
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

        # `ui.mouse_capture` は既定 (true) のまま。tmux / zellij ではマウスを切って
        # いるが、herdr はサイドバー自体がマウス UI で、init.el の xterm-mouse-mode
        # や gitui / bottom もマウスを使うため、ここだけ流儀を合わせない。

        # 既存の config.toml を踏襲して macOS の通知センターへ出す。
        toast.delivery = "system";
      };

      experimental = {
        # 日本語入力対策 (macOS 限定・best-effort)。prefix 中だけ ASCII 入力へ
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
  xdg.configFile."herdr/config.toml".onChange = lib.mkForce ''
    /opt/homebrew/bin/herdr server reload-config || true
  '';
}
