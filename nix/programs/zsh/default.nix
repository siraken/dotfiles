{ pkgs, ... }:
let
  optionScript = builtins.readFile ./option.zsh;
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

    shellGlobalAliases = {
      G = "| grep";
      L = "| less";
      F = "| fzf";
      C = "| pbcopy";
    };

    initExtra = ''
      ${optionScript}
    '';
  };
}
