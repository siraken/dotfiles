#!/bin/bash

packages=(
)

# Install packages
printf "Installing npm packages..."

for package in "${packages[@]}"
do
    deno install $package
done
