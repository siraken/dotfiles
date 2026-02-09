{ pkgs, lib, ... }:
let
  functionsScript = builtins.readFile ./function.sh;
  messagesScript = builtins.readFile ./messages.sh;
  aliasesScript = builtins.readFile ./alias.sh;
  evalScript = builtins.readFile ./eval.sh;
in
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

    # Extra configuration for .bashrc
    initExtra = ''
      # Message functions
      ${messagesScript}

      # Conditional aliases
      ${aliasesScript}

      # Custom functions
      ${functionsScript}

      # External tools (GCP, Angular CLI)
      ${evalScript}
    '';
  };
}
