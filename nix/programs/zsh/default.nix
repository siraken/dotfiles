{
  config,
  lib,
  pkgs,
  repoPath,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # Resolve symlinks in fpath and drop missing entries before compinit so
    # `typeset -U fpath` collapses identical Nix store targets (otherwise Nix's
    # zsh sees its own functions dir three times: ~/.nix-profile,
    # /run/current-system/sw, and its built-in store path).
    #
    # Key the completion dump by $ZSH_VERSION under XDG_CACHE_HOME. On macOS
    # Apple's /bin/zsh (5.9) and Nix's zsh (5.9.2) both run on the same host
    # (login shell vs. tools invoking pkgs.zsh); sharing one .zcompdump causes
    # a full ~0.8-1.5 s rebuild whenever the other version runs.
    completionInit = ''
      fpath=(''${^fpath}(N-/:A))
      [[ -d "${config.xdg.cacheHome}/zsh" ]] || mkdir -p "${config.xdg.cacheHome}/zsh"
      autoload -U compinit && compinit -d "${config.xdg.cacheHome}/zsh/zcompdump-$ZSH_VERSION"
    '';
    autocd = true;
    defaultKeymap = "emacs";
    setOptions = [
      "LIST_PACKED"
      "CORRECT"
    ];

    history = {
      # 履歴は設定ではなく状態なので、dotDir (~/.config/zsh) ではなく
      # XDG_STATE_HOME に置く。
      path = "${config.xdg.stateHome}/zsh/history";
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    shellGlobalAliases = {
      G = "| grep";
      L = "| less";
      F = "| fzf";
    }
    # pbcopy exists only on macOS.
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      C = "| pbcopy";
    };

    # Source the repo fragments directly (`repoPath` follows
    # `dotfiles.linkMode`, so with the checkout a new shell picks up edits
    # without a rebuild). See #70.
    initContent = ''
      source ${repoPath "config/zsh/option.zsh"}

      # Custom functions
      source ${repoPath "config/zsh/function.zsh"}

      # Report the cwd to the terminal (OSC 7)
      source ${repoPath "config/zsh/osc7.zsh"}
    '';
  };
}
