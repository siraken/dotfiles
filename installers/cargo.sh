#!/bin/bash

packages=(
  "cargo-binstall"
  "cargo-generate"
  "diesel_cli"
  "dioxus-cli"
  "du-dust"
  "evcxr_repl"
  "gitoxide"
  "pagefind"
  "spotify_player"
)

# Install packages
printf "Installing packages..."

for package in "${packages[@]}"; do
  cargo install $package
done
