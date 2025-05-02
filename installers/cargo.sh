#!/bin/bash

pkgs=(
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

for pkg in "${pkgs[@]}"; do
  cargo install $pkg
done
