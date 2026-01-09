{ pkgs, ... }:
let
  optionScript = builtins.readFile ./option.zsh;
  sharedAliases = import ../../modules/aliases.nix { };
in
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

    # Shell aliases (import shared)
    shellAliases = sharedAliases;

    shellGlobalAliases = {
      G = "| grep";
      L = "| less";
      F = "| fzf";
      C = "| pbcopy";
    };

    initContent = ''
      ${optionScript}
    '';
  };
}
