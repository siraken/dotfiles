#!/bin/bash

pkgs=(
  "diagrams"
  "safetensors"
  "frogmouth"
)

if [ -e "$HOME/.rye/shims" ]; then
  rye self update
  for pkg in "${pkgs[@]}"; do
    rye install "$pkg"
  done
else
  pip install --upgrade pip

  for pkg in "${pkgs[@]}"; do
    pip install "$pkg"
  done
fi
