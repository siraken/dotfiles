#!/bin/bash

pkgs=(
  "xdebug"
)

for pkg in "${pkgs[@]}"; do
  pecl install $pkg
done
