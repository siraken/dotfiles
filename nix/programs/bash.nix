{ pkgs, ... }:
{
  programs.bash = {
    enable = false;
    enableCompletion = true;
    # historyControl = ["ignoredups" "erasedups"];
    # historyIgnore = ["ls *" "cd *" "pwd" "exit"];
  };
}
