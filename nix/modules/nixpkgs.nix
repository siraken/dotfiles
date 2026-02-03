# CLI tools migrated from Homebrew
{ pkgs }:
with pkgs;
let
  # File operations and browsing
  fileTools = [
    broot # file manager
    duf # df replacement
    dust # du replacement
    eza # ls replacement
    fd # find replacement
    ripgrep # grep replacement
    tree # directory tree
  ];

  # JSON processing
  jsonTools = [
    fx # JSON viewer
    jless # JSON pager
    jq # JSON processor
  ];

  # Network utilities
  networkTools = [
    aria2 # downloader
    bandwhich # network bandwidth monitor
    httpie # curl replacement
    wget # downloader
    whois # domain info
  ];

  # System information and benchmarks
  systemInfoTools = [
    hyperfine # benchmark tool
    neofetch # system info
    onefetch # git repo info
    procs # ps replacement
    tokei # code line counter
  ];

  # Terminal UI and productivity
  terminalTools = [
    delta # git diff enhancement (brew: git-delta)
    genact # fake build animation
    glow # Markdown viewer
    gum # shell script UI
    navi # cheatsheet
    pastel # color tool
    tealdeer # man replacement (brew: tldr)
    vhs # terminal recording
    blesh # line editor written in pure Bash
  ];

  # Miscellaneous CLI tools
  miscCliTools = [
    hugo # static site generator
  ];

  # Programming languages
  languages = [
    bun # JavaScript/TypeScript runtime
    clojure
    dart
    deno # JavaScript/TypeScript runtime
    elmPackages.elm
    kotlin
    lua
    nim
    pnpm # Node.js package manager
    # sbcl # Common Lisp (disabled: ECL build fails on macOS)
    scala
  ];

  # Build systems
  buildTools = [
    cmake
    gradle
    maven
    ninja
    sbt # Scala build
  ];

  # Cloud and infrastructure
  cloudTools = [
    act # GitHub Actions local runner
    ansible # configuration management
    cloudflared # Cloudflare tunnel
    flyctl # Fly.io CLI
    kompose # K8s conversion
    minikube # K8s local
    tenv # Terraform version manager
  ];

  # Development utilities
  devUtilTools = [
    ghq # repository manager
    graphviz # graph visualization
    lua-language-server # LSP
    luarocks # Lua packages
    mkcert # local certificates
    pandoc # document conversion
    tor # anonymous network
    tree-sitter # parser
  ];

  textEditors = [
    neovim # vim-based editor
  ];
in
fileTools
++ jsonTools
++ networkTools
++ systemInfoTools
++ terminalTools
++ miscCliTools
++ languages
++ buildTools
++ cloudTools
++ devUtilTools
++ textEditors
