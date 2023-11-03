#!/bin/bash

packages=(
    "dart_frog_cli"
)

for package in "${packages[@]}"
do
    dart pub global activate $package
done
