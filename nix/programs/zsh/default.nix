{ config, mkRepoLink, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "emacs";

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

    # Source option.zsh from an out-of-store symlink so it is editable in place
    # (a new shell picks up edits — no rebuild). See #70.
    initContent = ''
      source ${config.home.homeDirectory}/.config/zsh/option.zsh
    '';
  };

  home.file.".config/zsh/option.zsh".source = mkRepoLink "config/zsh/option.zsh";
}
