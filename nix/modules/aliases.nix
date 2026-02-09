{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dotfiles.aliases;
in
{
  options.dotfiles.aliases = {
    enable = lib.mkEnableOption "shared shell aliases";
    extraAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Additional shell aliases to merge";
    };
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = {
      # Git
      g = "git";
      gs = "git status";

      # File operations
      fzf = "fzf --preview 'bat --color=always --style=numbers {}'";
      cls = "clear";
      md = "mkdir";

      # Editors
      e = "emacs";
      ee = "emacsclient -nw";
      emacsd = "emacs --daemon";
      vim = "nvim";

      # Date/Time
      datetime = "date '+%Y-%m-%d %H:%M:%S'";

      # PHP/Laravel
      sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
      dep = "[ -f dep ] && sh dep || sh vendor/bin/dep";

      # Misc
      mrm = "touch README.md";

      # Language shortcuts
      rb = "ruby";
      py = "python";
      n = "node";
      gpp = "g++";

      # Go
      gopj = "cd $GOPATH/src/github.com/";

      # Rust
      rustrepl = "evcxr";

      # DevOps
      tf = "terraform";
      act = "act --container-architecture linux/amd64";

      # Applications
      spt = "spotify_player";
      wez = "wezterm";

      # Mise
      mr = "mise run";

      # AI tools
      cc = "claude";
      ccd = "claude --dangerously-skip-permissions";
      oc = "opencode";
      ccu = "bunx ccusage@latest";
      cculv = "bunx ccusage@latest blocks --live";
      cx = "codex";
      di = "bunx difit";
      ccm = "bunx ccmanager";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      # macOS specific
      ii = "open";
      mamp-htdocs = "cd /Applications/MAMP/htdocs";
      lisp-server = "sbcl --load $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp";
    }
    // cfg.extraAliases;
  };
}
