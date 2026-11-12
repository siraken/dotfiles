{
  config,
  lib,
  pkgs,
}:
{
  BASH_SILENCE_DEPRECATION_WARNING = "1";
  CLICOLOR = "true";
  EDITOR = "nvim";

  # TERM はここで固定しない。端末エミュレータ (Ghostty/kitty/WezTerm) や tmux が
  # 自分に合った値を渡してくるので、上書きすると truecolor などの機能検出を潰す。

  # XDG_CONFIG_HOME と仲間は `xdg.enable` (base プロファイル) が export する。
  GOPATH = "$HOME/go";
  MODULAR_HOME = "$HOME/.modular";
  # hm-session-vars.sh は名前順に export するので、"$XDG_CONFIG_HOME/composer"
  # と書くと XDG_CONFIG_HOME より先に展開され、継承していない環境では
  # "/composer" になる。評価時に絶対パスへ解決しておく。
  COMPOSER_HOME = "${config.xdg.configHome}/composer";
  BUN_INSTALL = "$HOME/.bun";
}
// lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
  # 1Password の SSH エージェント。WSL では別の経路 (npiperelay) を使うため、
  # このソケットのパスは macOS でしか通用しない。
  SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  # homebrew で入れた JDK。prefix ごと macOS 専用。
  JAVA_HOME = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home";

  # Android Studio の SDK Manager が管理する SDK。~/Library 以下なので macOS 専用。
  # PATH の platform-tools は base プロファイル (path.nix) にあり、この変数は
  # full でしか定義されないので、そちらはリテラルのままにしておく。
  ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
}
