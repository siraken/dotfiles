#!/bin/bash

# List of pip packages to install
packages=(
  "diagrams"
)

# Install packages
printf "Installing packages..."

pip install --upgrade pip

for package in "${packages[@]}"
do
  pip install "$package"
done
