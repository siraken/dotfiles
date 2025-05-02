#!/bin/bash

pkgs=(
  "laravel/installer"
  "psy/psysh:@stable"
  "awssat/tailwindo"
)

for pkg in "${pkgs[@]}"; do
  composer global require $pkg
done
