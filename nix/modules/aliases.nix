# Shell aliases, split by home-manager profile like `packages.nix`.
#
# An alias lives in the same tier as the tool it calls, so a smaller profile
# never gets an alias that points at a command it does not install (e.g.
# `vim = nvim` without nixvim, or `e = emacs` without emacs).
{ pkgs }:
let
  inherit (pkgs.lib) optionalAttrs;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  base = {
    # Git
    g = "git";
    gs = "git status";

    # File operations
    cat = "bat";
    ll = "eza -l -g --icons --sort=type";
    lla = "ll -a";
    fzf = "fzf --preview 'bat --color=always --style=numbers {}'";
    cls = "clear";
    md = "mkdir";

    # Date/Time
    datetime = "date '+%Y-%m-%d %H:%M:%S'";

    # Misc
    mrm = "touch README.md";
  }
  // optionalAttrs isDarwin {
    ii = "open";
  };

  standard = {
    # Editors
    vim = "nvim";

    # Mise
    mr = "mise run";
  };

  full = {
    # Editors
    e = "emacs";
    ee = "emacsclient -nw";
    emacsd = "emacs --daemon";

    # PHP/Laravel
    sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
    dep = "[ -f dep ] && sh dep || sh vendor/bin/dep";

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
    hr = "herdr";

    # AI tools
    cc = "claude";
    ccd = "claude --dangerously-skip-permissions";
    oc = "opencode";
    cx = "codex";
  }
  // optionalAttrs isDarwin {
    mamp-htdocs = "cd /Applications/MAMP/htdocs";
    lisp-server = "sbcl --load $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp";
  };
}
