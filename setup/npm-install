#!/bin/bash

# List of npm packages to install in global
packages=(
  "typescript"
  "source-map-support"
  "prettier"
)

# Install packages
printf "Installing npm packages..."

for package in "${packages[@]}"
do
  npm install -g $package
done
