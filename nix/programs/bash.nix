{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # historyControl = ["ignoredups" "erasedups"];
    # historyIgnore = ["ls *" "cd *" "pwd" "exit"];
  };
}
