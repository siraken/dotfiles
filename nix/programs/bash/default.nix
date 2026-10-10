{ pkgs, repoPath, ... }:
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

    # Source the repo fragments directly (`repoPath` follows
    # `dotfiles.linkMode`, so with the checkout a new shell picks up edits
    # without a rebuild). See #70.
    initExtra = ''
      # Custom functions
      source ${repoPath "config/bash/function.sh"}

      # Report the cwd to the terminal (OSC 7)
      source ${repoPath "config/bash/osc7.sh"}
    '';
  };
}
