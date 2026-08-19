{ pkgs }:
let
  commonAliases = {
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
    hr = "herdr";

    # Mise
    mr = "mise run";

    # Socket Firewall 経由のパッケージマネージャ (npm/pnpm/bun など) は、`sfw` が
    # Nix 管理外で入っていない環境だとコマンドごと壊れてしまうため、ここでは定義せず
    # 各シェルの条件付きエイリアス側に置いている。

    # AI tools
    cc = "claude";
    ccd = "claude --dangerously-skip-permissions";
    oc = "opencode";
    cx = "codex";
  };

  darwinAliases = pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
    # macOS specific
    ii = "open";
    mamp-htdocs = "cd /Applications/MAMP/htdocs";
    lisp-server = "sbcl --load $HOME/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp";
  };
in
commonAliases // darwinAliases
