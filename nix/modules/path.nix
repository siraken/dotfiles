# User PATH entries added via `home.sessionPath`, split by home-manager profile
# like `packages.nix` and `aliases.nix` (`base` ⊂ `standard` ⊂ `full`).
#
# Homebrew prefixes are deliberately excluded from `home.sessionPath`, which is
# prepended ahead of Nix profiles in `hm-session-vars.sh` and would let
# Homebrew formulas shadow Nix packages. On macOS, `homebrew` below is placed
# after Nix profiles and before `/usr/bin` via `environment.systemPath`
# (`nix/modules/darwin/base.nix`) and the Darwin shell profile helpers.
#
# 相対パスの "bin" はカレントディレクトリ次第で別物を指してしまうため入れない。
{ lib, pkgs }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  base = [
    "$HOME/bin"
    "$HOME/.local/bin"
  ];

  standard = [
    # `programs.mise` lives in the `standard` profile.
    "$HOME/.local/share/mise/shims"
  ];

  full = [
    "$HOME/.progate/bin"
    "$HOME/.slack/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/Developer/flutter/bin"
    "$HOME/.deno/bin"
    "$HOME/.cargo/bin"
    "$HOME/.rye/shims"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
    "$COMPOSER_HOME/vendor/bin"
  ]
  # ~/Library 以下は macOS にしか無いので、Linux (WSL/NixOS) の PATH には入れない。
  ++ lib.optionals isDarwin [
    "$HOME/Library/Application Support/Coursier/bin"
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    "$HOME/Library/Android/sdk/platform-tools"
    "$HOME/Library/pnpm/bin"
  ];

  # Homebrew prefixes for macOS: placed after Nix profiles and before `/usr/bin`
  # so Nix packages take priority over Homebrew formulas while Homebrew
  # (including keg-only openssl@3) still beats Apple's `/usr/bin`.
  homebrew = [
    "/opt/homebrew/opt/openssl@3/bin" # Use openssl installed by homebrew
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];
}
