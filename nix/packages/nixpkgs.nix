# High-priority CLI tools migrated from Homebrew
# See: https://github.com/siraken/dotfiles/issues/31
{ pkgs }:
with pkgs;
[
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
]
