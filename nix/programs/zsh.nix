{ pkgs, ... }:
{
  programs.zsh = {
    enable = false;
    enableCompletion = true;
    # autocd = true;
    # autosuggestion = {
    #   enable = true;
    #   highlight = null;
    #   strategy = ["history"];
    # };
    # completionInit = "autoload -Uz compinit && compinit";
    # enableBashCompletion = true;
    # enableFastSyntaxHighlighting = true;
    # enableFzfCompletion = true;
    # enableFzfGit = true;
    # enableFzfHistory = true;
  };
}
