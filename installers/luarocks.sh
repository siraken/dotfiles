#!/bin/bash

pkgs=(
  "lapis"
)

for pkg in "${pkgs[@]}"; do
  luarocks install "$pkg"
done
