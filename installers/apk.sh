#!/bin/bash

REPOSITORIES=(
)

PACKAGES=(
    "bash"
    "zsh"
    "git"
    "go"
    "openssh"
    "openssl"
    "github-cli"
    "tmux"
    "sudo"
    "vim"
    "neovim"
    "emacs"
    "exa"
    "neofetch"
    "docker"
    "nginx"
    "php81"
)

# Update package list
printf "Updating package list...\n"
sudo apk update
sudo apk upgrade

# Install packages
for package in "${PACKAGES[@]}"; do
    if [ "$package" != "" ]; then
        printf "Installing $package...\n"
        sudo apk add $package
    fi
done

