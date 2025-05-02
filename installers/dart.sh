#!/bin/bash

pkgs=(
  "dart_frog_cli"
)

for pkg in "${pkgs[@]}"; do
  dart pub global activate $pkg
done
