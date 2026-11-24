{
  config,
  lib,
  pkgs,
  repoPath,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  paths = import ../../modules/path.nix { inherit lib pkgs; };
  # Order from lowest to highest priority so prepending each entry in turn
  # restores `home.sessionPath > Nix profiles > Homebrew > system paths`.
  darwinFrontPaths =
    lib.reverseList paths.homebrew
    ++ [
      "/nix/var/nix/profiles/default/bin"
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ]
    ++ lib.reverseList config.home.sessionPath;
  quoteForBash = p: "\"${lib.escape [ "\"" "\\" "`" ] p}\"";
in
{
  programs.bash = {
    enable = true;
    package = pkgs.bashInteractive;
    enableCompletion = false;

    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "exit"
    ];
    historySize = 10000;
    historyFileSize = 20000;

    # Shell options (configured in initExtra instead)
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];

    # macOS's /etc/profile runs path_helper, which moves /usr/bin ahead of
    # everything already on PATH. nix-darwin's set-environment would put the
    # Nix profiles back in front, but a login shell that inherits
    # __NIX_DARWIN_SET_ENVIRONMENT_DONE skips it (and skips hm-session-vars.sh
    # when __HM_SESS_VARS_SOURCED is set), leaving Apple's /usr/bin ahead of
    # both Nix profiles and home.sessionPath. Restore the same precedence as
    # zsh here: home.sessionPath > Nix profiles > Homebrew > system paths.
    profileExtra = lib.optionalString isDarwin ''
      for p in ${lib.concatMapStringsSep " " quoteForBash darwinFrontPaths}; do
        [ -n "$p" ] || continue
        PATH=":$PATH:"
        while [[ "$PATH" == *":$p:"* ]]; do
          PATH="''${PATH//:$p:/:}"
        done
        PATH="''${PATH#:}"
        PATH="''${PATH%:}"
        PATH="$p''${PATH:+:$PATH}"
      done
      unset p
      export PATH
    '';

    # Source the repo fragments directly (`repoPath` follows
    # `dotfiles.linkMode`, so with the checkout a new shell picks up edits
    # without a rebuild). See #70.
    initExtra = ''
      # Custom functions
      source ${repoPath "config/bash/function.sh"}

      # Report the cwd to the terminal (OSC 7)
      source ${repoPath "config/bash/osc7.sh"}
    '';
  };
}
