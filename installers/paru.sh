#!/bin/bash

packages=(
    # "rbenv"
)

# Install paru if not installed
yay paru

# Update package list
printf "Updating package list...\n"
paru

# Install packages
for package in "${packages[@]}"; do
    if [ "$package" != "" ]; then
        printf "Installing $package...\n"
        paru $package
    fi
done

