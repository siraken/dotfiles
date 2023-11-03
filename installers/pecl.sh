#!/bin/bash

packages=(
    "xdebug"
)

for package in "${packages[@]}"
do
    pecl install $package
done
