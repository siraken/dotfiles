#!/bin/bash

REPOSITORIES=(
    "ppa:neovim-ppa/stable"
    "universe"
    # "https://dl.hhvm.com/ubuntu"
)

PACKAGES=(
    "git"
    "curl"
    "wget"
    "libfuse2"
    "tree"
    "fish"
    "neovim"
    "bat"
    "neofetch"
    "luajit"
    "exa"
    # "hhvm"
    # "powershell"
)

# Initial setup
sudo apt-get update -y
sudo apt-get install -y software-properties-common apt-transport-https

# sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94

# add-apt-repository
for REPO in "${REPOSITORIES[@]}"; do
    if [ "$REPO" != "" ]; then
        printf "Adding apt repository: $REPO...\n"
        sudo add-apt-repository $REPO -y
    fi
done

# Update package list
printf "Updating package list...\n"
sudo apt update -y

# Install packages
for package in "${PACKAGES[@]}"; do
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

