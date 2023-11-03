#!/bin/bash

packages=(
    "rubocop"
    "rufo"
    "solargraph"
    "neovim"
)

# Install packages
printf "Installing packages..."

for package in "${packages[@]}"
do
  gem install $package
done
