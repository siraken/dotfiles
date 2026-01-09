{ pkgs, lib, ... }:
let
  functionsScript = builtins.readFile ./function.sh;
  messagesScript = builtins.readFile ./messages.sh;
  aliasesScript = builtins.readFile ./alias.sh;
  evalScript = builtins.readFile ./eval.sh;
  sharedAliases = import ../../modules/aliases.nix { };
in
{
  programs.bash = {
    enable = true;
    package = pkgs.bashInteractive;
    enableCompletion = false;

    historyControl = [
      "ignoredups"
      "erasedups"
    ];
    historyIgnore = [
      "ls *"
      "cd *"
      "pwd"
      "exit"
    ];
    historySize = 10000;
    historyFileSize = 20000;

    # Shell options (configured in initExtra instead)
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];

    # Environment variables
    sessionVariables = {
      BASH_SILENCE_DEPRECATION_WARNING = "1";
      CLICOLOR = "true";
      TERM = "xterm-256color";
      EDITOR = "nvim";
      GH_URL = "https://github.com";
      AWS_PROFILE = "default";
      AWS_DEFAULT_REGION = "ap-northeast-1";

      XDG_CONFIG_HOME = "$HOME/.config";
      SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
      GOPATH = "$HOME/go";
      MODULAR_HOME = "$HOME/.modular";
      COMPOSER_HOME = "$XDG_CONFIG_HOME/composer";
      BUN_INSTALL = "$HOME/.bun";
      JAVA_HOME = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home";
    };

    # Shell aliases (import shared + bash-specific)
    shellAliases = sharedAliases;

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
