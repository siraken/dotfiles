#!/bin/bash

pkgs=(
  "rubocop"
  "rufo"
  "solargraph"
  "neovim"
)

for pkg in "${pkgs[@]}"; do
  gem install $pkg
done
