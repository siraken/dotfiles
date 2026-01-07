{ pkgs, lib, ... }:
let
  functionsScript = builtins.readFile ./function.sh;
  messagesScript = builtins.readFile ./messages.sh;
  aliasesScript = builtins.readFile ./alias.sh;
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

    # Shell aliases
    shellAliases = {
      g = "git";
      gs = "git status";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "fzf --preview 'bat --color=always --style=numbers {}'";
      cls = "clear";
      md = "mkdir";
      e = "emacs";
      ee = "emacsclient -nw";
      emacsd = "emacs --daemon";
      vim = "nvim";
      datetime = "date '+%Y-%m-%d %H:%M:%S'";
      sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
      dep = "[ -f dep ] && sh dep || sh vendor/bin/dep";
      mrm = "touch README.md";
      rb = "ruby";
      py = "python";
      n = "node";
      gpp = "g++";
      gopj = "cd $GOPATH/src/github.com/";
      rustrepl = "evcxr";
      tf = "terraform";
      spt = "spotify_player";
      act = "act --container-architecture linux/amd64";
      wez = "wezterm";
      mr = "mise run";
      cc = "claude";
      ccd = "claude --dangerously-skip-permissions";
      ccu = "bunx ccusage@latest";
      cculv = "bunx ccusage@latest blocks --live";
      cx = "codex";
      di = "bunx difit";
      ccm = "bunx ccmanager";

      # macOS specific
      ii = "open";
      mamp-htdocs = "cd /Applications/MAMP/htdocs";
      lisp-server = "sbcl --load $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp";
    };

    # Extra configuration for .bashrc
    initExtra = ''
      # Message functions
      ${messagesScript}

      # Conditional aliases
      ${aliasesScript}

      # Custom functions
      ${functionsScript}
    '';
  };
}
