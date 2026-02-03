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

    initContent = ''
      ${optionScript}

      # Set GitHub token for Nix to access private repositories
      if command -v gh &> /dev/null && gh auth status &> /dev/null 2>&1; then
        export NIX_CONFIG="access-tokens = github.com=$(gh auth token)"
      fi
    '';
  };
}
