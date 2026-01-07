{ ... }:
let
  functionsScript = builtins.readFile ./function.fish;
  completionScript = builtins.readFile ./completion.fish;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      # macOS specific
      ii = "open";
      mamp-htdocs = "cd /Applications/MAMP/htdocs";
      lisp-server = "sbcl --load $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp";
    };

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Custom functions
      ${functionsScript}

      # Completions
      ${completionScript}

      # Conditional aliases
      if type -q bat
        alias cat="bat"
      end

      if type -q eza
        alias ll="eza -l -g --icons"
        alias lla="ll -a"
      end
    '';
  };
}
