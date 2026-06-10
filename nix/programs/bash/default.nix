{
  pkgs,
  config,
  mkRepoLink,
  ...
}:
{
  programs.bash = {
    enable = true;
    package = pkgs.bashInteractive;
    enableCompletion = false;

    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "exit"
    ];
    historySize = 10000;
    historyFileSize = 20000;

    # Shell options (configured in initExtra instead)
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];

    # Source the fragments from out-of-store symlinks so they are editable in
    # place (a new shell picks up edits — no rebuild). Same order as before.
    # See #70.
    initExtra = ''
      # Message functions
      source ${config.home.homeDirectory}/.config/bash/messages.sh

      # Conditional aliases
      source ${config.home.homeDirectory}/.config/bash/alias.sh

      # Custom functions
      source ${config.home.homeDirectory}/.config/bash/function.sh

      # External tools (GCP, Angular CLI)
      source ${config.home.homeDirectory}/.config/bash/eval.sh
    '';
  };

  home.file = {
    ".config/bash/messages.sh".source = mkRepoLink "config/bash/messages.sh";
    ".config/bash/alias.sh".source = mkRepoLink "config/bash/alias.sh";
    ".config/bash/function.sh".source = mkRepoLink "config/bash/function.sh";
    ".config/bash/eval.sh".source = mkRepoLink "config/bash/eval.sh";
  };
}
