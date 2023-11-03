#!/bin/bash

packages=(
    # "rbenv"
)

# Install yay if not installed
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si && cd ../ && rm -rf yay

# Update package list
printf "Updating package list...\n"
yay

# Install packages
for package in "${packages[@]}"; do
    if [ "$package" != "" ]; then
        printf "Installing $package...\n"
        yay $package
    fi
done

