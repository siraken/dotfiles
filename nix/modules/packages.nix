# CLI tools migrated from Homebrew, split by home-manager profile.
#
# Each profile adds its own tier on top of the tiers below it
# (`base` ⊂ `standard` ⊂ `full`), so a tool belongs to the smallest profile
# that needs it:
#
# - base:     what you reach for on a production server over SSH
# - standard: interactive tooling for a host that is worked on
# - full:     language toolchains, build systems, cloud CLIs, and toys that
#             only a daily-driver workstation needs
{ pkgs }:
with pkgs;
{
  base = [
    # File operations and browsing
    duf # df replacement
    dust # du replacement
    eza # ls replacement
    fd # find replacement
    ripgrep # grep replacement
    tree # directory tree

    # JSON processing
    jq # JSON processor

    # Network utilities
    wget # downloader
    whois # domain info
  ];

  standard = [
    # File operations and browsing
    broot # file manager

    # JSON processing
    fx # JSON viewer
    jless # JSON pager

    # Network utilities
    aria2 # downloader
    bandwhich # network bandwidth monitor
    httpie # curl replacement

    # System information and benchmarks
    hyperfine # benchmark tool
    onefetch # git repo info
    procs # ps replacement
    tokei # code line counter

    # Terminal UI and productivity
    delta # git diff enhancement (brew: git-delta)
    glow # Markdown viewer
    navi # cheatsheet
    tealdeer # man replacement (brew: tldr)
    blesh # line editor written in pure Bash

    # Development utilities
    ghq # repository manager
    gibo # .gitignore generator
    lua-language-server # LSP
    nil # Nix LSP
    nixfmt # Nix formatter
    tree-sitter # parser
  ];

  full = [
    # Terminal UI and productivity
    genact # fake build animation
    gum # shell script UI
    pastel # color tool
    vhs # terminal recording

    # Miscellaneous CLI tools
    hugo # static site generator
    imapsync # IMAP mailbox synchronization
    powershell # cross-platform shell
    qsv # CSV toolkit (successor to xsv)

    # Programming languages
    bun
    lua
    nim
    pnpm # Node.js package manager
    purescript # PureScript compiler
    # sbcl # Common Lisp (disabled: ECL build fails on macOS)
    scala

    # Build systems
    cmake
    earthbuild # community fork of earthly (brew: earthly, upstream discontinued)
    gradle
    maven
    ninja
    sbt # Scala build

    # Cloud and infrastructure
    act # GitHub Actions local runner
    ansible # configuration management
    cloudflared # Cloudflare tunnel
    flyctl # Fly.io CLI
    rclone # cloud storage sync
    kompose # K8s conversion
    # minikube # K8s local — disabled: nixpkgs build failure (makeShellWrapper API change)
    tenv # Terraform version manager

    # Development utilities
    devenv # composable dev environments
    glab # GitLab CLI
    graphviz # graph visualization
    luarocks # Lua packages
    mkcert # local certificates
    ni # @antfu/ni - use the right package manager
    pandoc # document conversion
    tea # Gitea CLI
    tor # anonymous network
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    container # container platform for macOS
  ];
}
