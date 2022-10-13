#!/bin/bash

packages=(
    "software-properties-common"
    "apt-transport-https"
    "git"
    "curl"
    "wget"
    "tree"
    "fish"
    "neovim"
    "bat"
    "neofetch"
    "luajit"
    "nodejs"
    "npm"
    # "hhvm"
    # "powershell"
)

repositories=(
    "ppa:neovim-ppa/stable"
    # "https://dl.hhvm.com/ubuntu"
)

# Update package list
sudo apt update

# sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94

# add-apt-repository
for repository in "${repositories[@]}"; do
  if [ "$repository" != "" ]; then
    printf "Adding apt repository: $repository...\n"
    sudo add-apt-repository $repository -y
  fi
done

# Update package list
printf "Updating package list...\n"
sudo apt update -y

# Install packages
for package in "${packages[@]}"; do
  if [ "$package" != "" ]; then
    printf "Installing $package...\n"
    sudo apt install -y $package
  fi

  # Rename for bat
  if [ "$package" == "bat" ]; then
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat /usr/local/bin/bat
  fi
done

