{ repoPath, ... }:
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
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    shellGlobalAliases = {
      G = "| grep";
      L = "| less";
      F = "| fzf";
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
