#!/bin/bash

packages=(
  "bat"
  "exa"
  "fish"
  "gh"
  "git"
  "golang"
  "neofetch"
  "neovim"
  "nodejs-lts"
  "tmux"
  "tree"
  "vim"
  "wget"
  "yarn"
)

# Update package list
printf "Updating package list..."
pkg update -y

# Install packages
for package in "${packages[@]}"; do
  if [ "$package" != "" ]; then
    printf "Installing $package..."
    pkg install -y $package
  fi
done

