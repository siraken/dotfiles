#!/bin/bash

packages=(
    "base-devel"
    "curl"
    "wget"
    "git"
    "sudo"
    "fish"
    "neofetch"
    "onefetch"
    "vim"
    "neovim"
    "emacs"
    "github-cli"
    "deno"
    "starship"
    "tmux"
    "jq"
    "rust"
    "go"
    "lua"
    "luajit"
    "luarocks"
    "eza"
    "bat"
    "ffmpeg"
    "inetutils"
    "mkcert"
    "yt-dlp"
    "lazygit"
    "jless"
    "cloudflared"
    "httpie"
    "lua-language-server"
    "dart"
    "jdk-openjdk"
    "gradle"
    "maven"
    "kotlin"
    "clojure"
    "leiningen"
    "sbcl"
    "tree-sitter"
    "openssh"
    "dotnet-sdk"
)

# Update package list
printf "Updating package list...\n"
sudo pacman -Syyu --noconfirm

# Install packages
for package in "${packages[@]}"; do
    if [ "$package" != "" ]; then
        printf "Installing $package...\n"
        sudo pacman -S --noconfirm $package
    fi
done

