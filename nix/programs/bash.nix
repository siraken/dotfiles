{ pkgs, lib, ... }:
{
  programs.bash = {
    enable = true;
    package = pkgs.bash;
    enableCompletion = true;

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
    # shellOptions = [
    #   "histappend"
    #   "checkwinsize"
    # ];

    # Environment variables
    sessionVariables = {
      BASH_SILENCE_DEPRECATION_WARNING = "1";
      CLICOLOR = "true";
      TERM = "xterm-256color";
      EDITOR = "nvim";
      # GH_URL = "https://github.com";
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

    # PATH configuration (configured in initExtra instead)
    # Note: Many paths are added by Nix automatically for packages installed via home.packages
    # sessionPath = [
    #   "/opt/homebrew/opt/openssl@3/bin"
    #   "/opt/homebrew/sbin"
    #   "/opt/homebrew/bin"
    #   "bin"
    #   "$HOME/bin"
    #   "$HOME/.local/bin"
    #   "$HOME/.progate/bin"
    #   "$HOME/.slack/bin"
    #   "$HOME/Library/Application Support/Coursier/bin"
    #   "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    #   "$HOME/Library/Android/sdk/platform-tools"
    #   "$HOME/.pub-cache/bin"
    #   "$HOME/Developer/flutter/bin"
    #   "$HOME/.deno/bin"
    #   "$HOME/.cargo/bin"
    #   "$HOME/.rye/shims"
    #   "$COMPOSER_HOME/vendor/bin"
    #   "$GOPATH/bin"
    #   "$BUN_INSTALL/bin"
    # ];

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

    # Additional initialization
    initExtra = ''
      # Shell options
      shopt -s histappend
      shopt -s checkwinsize

      # PATH configuration
      export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
      export PATH="/opt/homebrew/sbin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="bin:$PATH"
      export PATH="$HOME/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.progate/bin:$PATH"
      export PATH="$HOME/.slack/bin:$PATH"
      export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"
      export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
      export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
      export PATH="$HOME/.pub-cache/bin:$PATH"
      export PATH="$HOME/Developer/flutter/bin:$PATH"
      export PATH="$HOME/.deno/bin:$PATH"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/.rye/shims:$PATH"
      export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
      export PATH="$GOPATH/bin:$PATH"
      export PATH="$BUN_INSTALL/bin:$PATH"

      # Utility functions for messages
      info_message() {
        local message="$1"
        tput setab 4
        tput setaf 7
        printf " INFO "
        tput sgr0
        printf " %s\n" "$message"
      }

      success_message() {
        local message="$1"
        tput setab 2
        tput setaf 7
        printf " SUCCESS "
        tput sgr0
        printf " %s\n" "$message"
      }

      error_message() {
        local message="$1"
        tput setab 1
        tput setaf 7
        printf " ERROR "
        tput sgr0
        printf " %s\n" "$message"
      }

      warning_message() {
        local message="$1"
        tput setab 3
        tput setaf 7
        printf " WARNING "
        tput sgr0
        printf " %s\n" "$message"
      }

      debug_message() {
        local message="$1"
        tput setab 5
        tput setaf 7
        printf " DEBUG "
        tput sgr0
        printf " %s\n" "$message"
      }

      # Custom functions
      vetero() {
        curl wttr.in/$1
      }

      goinit() {
        echo "Enter the package name:" && read package;
        mkdir -p $package && cd $package
        go mod init github.com/$USER/$package
        git init && touch main.go README.md
      }

      laravelinit() {
        echo "Enter the project name:" && read projName;
        curl -s "https://laravel.build/$projName" | bash
      }

      gau() {
        echo "Enter the username:" && read username;
        if [[ -n "$username" ]]; then
          git remote add origin "$GH_URL/$username/$(basename $(pwd)).git"
          git remote -v
        else
          echo "Please provide the username you want to use."
        fi
      }

      gd() {
        local dir
        dir=$(ghq list -p | fzf)
        if [[ -n "$dir" ]]; then
          cd "$dir"
        fi
      }

      gco() {
        local branch
        branch=$(git branch --all | sed 's/^[* ]*//' | fzf)
        if [[ -n "$branch" ]]; then
          git checkout "$(echo $branch | sed 's#remotes/origin/##')"
        fi
      }

      ggl() {
        echo "Searching for $@ on Google..."
        open "https://www.google.com/search?q=$@"
      }

      meme() {
        echo "Searching for $@ on Know Your Meme..."
        open "https://knowyourmeme.com/search?q=$@"
      }

      cani() {
        echo "Can I use \"$@\"...?"
        open "https://caniuse.com?search=$@"
      }

      caniemail() {
        echo "Can I email \"$@\"...?"
        open "https://caniemail.com/search/?s=$@"
      }

      ide() {
        tmux split-window -v -p 30
        tmux split-window -h -p 50
      }

      ccc() {
        tmux split-window -h && \
        tmux split-window -v && \
        tmux select-pane -t 0 && \
        tmux split-window -v && \
        tmux select-pane -t 2 && \
        tmux split-window -v && \
        tmux select-pane -t 4 && \
        tmux split-window -v
      }

      cccw() {
        CURRENT_DIR=$(pwd)
        CURRENT_PANE=$WEZTERM_PANE
        RIGHT_TOP=$(wezterm cli split-pane --right --percent 50)
        wezterm cli activate-pane --pane-id $CURRENT_PANE
        RIGHT_BOTTOM=$(wezterm cli split-pane --bottom --percent 50)
        wezterm cli activate-pane --pane-id $RIGHT_TOP
        wezterm cli split-pane --bottom --percent 50
      }

      # Restart yabai and skhd
      res-yabai() {
        yabai --restart-service
        skhd --restart-service
      }

      # Conditional aliases
      if type bat > /dev/null 2>&1; then
        alias cat="bat"
      fi

      if type eza > /dev/null 2>&1; then
        alias ll="eza -l -g --icons"
        alias lla="ll -a"
      fi

      # Google Cloud SDK
      if [ -f "$HOME/Developer/google-cloud-sdk/path.bash.inc" ]; then
        . "$HOME/Developer/google-cloud-sdk/path.bash.inc"
      fi

      if [ -f "$HOME/Developer/google-cloud-sdk/completion.bash.inc" ]; then
        . "$HOME/Developer/google-cloud-sdk/completion.bash.inc"
      fi

      # Git completion
      if [ -f "$HOME/dotfiles/.config/bash/completions/git-completion.bash" ]; then
        . "$HOME/dotfiles/.config/bash/completions/git-completion.bash"
      fi

      # Angular completion
      if type ng &>/dev/null; then
        source <(ng completion script)
      fi

      # Tool integrations (mise, direnv, starship, zoxide are managed by their respective Nix modules)
    '';
  };
}
