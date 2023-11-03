#!/bin/bash

packages=(
    "laravel/installer"
    "psy/psysh:@stable"
    "awssat/tailwindo"
)

for package in "${packages[@]}"
do
    composer global require $package
done
