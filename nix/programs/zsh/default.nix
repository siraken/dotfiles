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

    # Source option.zsh from the repo directly (`repoPath` follows
    # `dotfiles.linkMode`, so with the checkout a new shell picks up edits
    # without a rebuild). See #70.
    initContent = ''
      source ${repoPath "config/zsh/option.zsh"}
    '';
  };
}
