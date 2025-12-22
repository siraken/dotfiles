{ pkgs, modulePath, ... }:
{
  environment.systemPackages = with pkgs; [
    # uv
    # ===== from `apk` =====
    # bash
    # git
    # go
    # openssh
    # openssl
    # gh
    # tmux
    # sudo
    # emacs
    # eza
    # neofetch
    # docker
    # nginx
    # php81
    # ===== from `apt` =====
    git
    # curl
    # wget
    # libfuse2 -> not found
    tree
    neovim
    # bat
    neofetch
    # luajit
    # eza
    # # hhvm -> not found
    # # powershell
    # ===== from `pkg` =====
    # bat
    # eza
    # gh
    # git
    # go
    # neofetch
    # nodejs-lts -> not found
    # tmux
    # tree
    # wget
    # yarn
    # openssh
    # ===== from `snap` =====
    # spt -> not found
    # ===== from `pacman` =====
    # base-devel -> not found
    # libyaml
    # curl
    # wget
    # git
    # sudo
    # neofetch
    # onefetch
    # emacs
    # gh
    # deno
    # starship
    # tmux
    # jq
    # rust
    # go
    # lua
    # luajit
    # luarocks -> not found?
    # eza
    # bat
    # ffmpeg
    # inetutils
    # mkcert
    # yt-dlp
    # lazygit
    # jless
    # cloudflared
    # httpie
    # lua-language-server
    # dart
    # jdk-openjdk -> should be specified
    # gradle
    # maven
    # kotlin
    # clojure
    # leiningen
    # sbcl
    # tree-sitter
    # openssh
  ];
}
