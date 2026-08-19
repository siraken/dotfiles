{ lib, pkgs }:
{
  BASH_SILENCE_DEPRECATION_WARNING = "1";
  CLICOLOR = "true";
  EDITOR = "nvim";

  # TERM はここで固定しない。端末エミュレータ (Ghostty/kitty/WezTerm) や tmux が
  # 自分に合った値を渡してくるので、上書きすると truecolor などの機能検出を潰す。

  XDG_CONFIG_HOME = "$HOME/.config";
  GOPATH = "$HOME/go";
  MODULAR_HOME = "$HOME/.modular";
  COMPOSER_HOME = "$XDG_CONFIG_HOME/composer";
  BUN_INSTALL = "$HOME/.bun";
}
// lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
  # 1Password の SSH エージェント。WSL では別の経路 (npiperelay) を使うため、
  # このソケットのパスは macOS でしか通用しない。
  SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  # homebrew で入れた JDK。prefix ごと macOS 専用。
  JAVA_HOME = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home";
}
