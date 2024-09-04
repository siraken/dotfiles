#!/bin/bash

# Install Rust if not installed
if ! type rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

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
