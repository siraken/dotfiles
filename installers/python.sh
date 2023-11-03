#!/bin/bash

packages=(
    "diagrams"
    "safetensors"
    "frogmouth"
)

# Install packages
if [ -e "$HOME/.rye/shims" ]; then
    rye self update
    for package in "${packages[@]}"
    do
        rye install "$package"
    done
else
    pip install --upgrade pip

    for package in "${packages[@]}"
    do
        pip install "$package"
    done
fi
