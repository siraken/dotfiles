# CLI tools migrated from Homebrew
# See: https://github.com/siraken/dotfiles/issues/31
# See: https://github.com/siraken/dotfiles/issues/32
{ pkgs }:
with pkgs;
let
  # High-priority CLI tools (#31)
  cliTools = [
    aria2 # downloader
    bandwhich # network bandwidth monitor
    broot # file manager
    duf # df replacement
    dust # du replacement
    eza # ls replacement
    fd # find replacement
    fx # JSON viewer
    genact # fake build animation
    delta # git diff enhancement (brew: git-delta)
    glow # Markdown viewer
    gum # shell script UI
    httpie # curl replacement
    hugo # static site generator
    hyperfine # benchmark tool
    jless # JSON pager
    jq # JSON processor
    navi # cheatsheet
    neofetch # system info
    onefetch # git repo info
    pastel # color tool
    procs # ps replacement
    tealdeer # man replacement (brew: tldr)
    tokei # code line counter
    tree # directory tree
    vhs # terminal recording
    wget # downloader
  ];

  # Development tools (#32)
  devTools = [
    act # GitHub Actions local runner
    ansible # configuration management
    cloudflared # Cloudflare tunnel
    cmake # build tool
    clojure # language
    dart # language
    elmPackages.elm # language
    flyctl # Fly.io CLI
    gradle # Java build
    graphviz # graph visualization
    kotlin # language
    kompose # K8s conversion
    lua # language
    lua-language-server # LSP
    luarocks # Lua packages
    maven # Java build
    minikube # K8s local
    mkcert # local certificates
    nim # language
    ninja # build tool
    pandoc # document conversion
    sbcl # Common Lisp
    sbt # Scala build
    scala # language
    tenv # Terraform version manager
    tor # anonymous network
    tree-sitter # parser
  ];
in
cliTools ++ devTools
