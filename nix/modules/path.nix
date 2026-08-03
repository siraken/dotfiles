{ lib, pkgs }:
# homebrew の prefix と ~/Library 以下は macOS にしか無いので、
# Linux (WSL/NixOS) の PATH には入れない。
lib.optionals pkgs.stdenv.isDarwin [
  "/opt/homebrew/opt/openssl@3/bin" # Use openssl installed by homebrew
  "/opt/homebrew/sbin"
  "/opt/homebrew/bin"
  "$HOME/Library/Application Support/Coursier/bin"
  "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  "$HOME/Library/Android/sdk/platform-tools"
  "$HOME/Library/pnpm/bin"
]
# 相対パスの "bin" はカレントディレクトリ次第で別物を指してしまうため入れない。
++ [
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.local/share/mise/shims"
  "$HOME/.progate/bin"
  "$HOME/.slack/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/Developer/flutter/bin"
  "$HOME/.deno/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rye/shims"
  "$COMPOSER_HOME/vendor/bin"
  "$HOME/go/bin"
  "$HOME/.bun/bin"
]
