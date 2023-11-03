#!/bin/bash

packages=(
    "lapis"
)

# Install packages
printf "Installing packages..."

for package in "${packages[@]}"
do
   luarocks install "$package"
done
