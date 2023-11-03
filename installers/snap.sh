#!/bin/bash

packages=(
    "spt"
)

# Update package list
printf "Updating package list...\n"
snap refresh

# Install packages
for package in "${packages[@]}"; do
    if [ "$package" != "" ]; then
        printf "Installing $package...\n"
        snap install $package
    fi
done
