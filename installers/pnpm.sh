#!/bin/bash

packages=(
    "typescript"
    "coffeescript"
    "nativescript"
    "@ionic/cli"
    "native-run"
    "source-map-support"
    "prettier"
    "@aws-amplify/cli"
    "firebase-tools"
    "commitizen"
    "@githubnext/github-copilot-cli"
    "@angular/cli"
    "@nestjs/cli"
    "fastify-cli"
    "yo"
    "json-server"
    "cordova"
    "typeorm"
    "wrangler"
    "@lhci/cli"
    "terminalizer"
    "dredd"
    "neovim"
)

# Install packages
printf "Installing npm packages using pnpm..."

for package in "${packages[@]}"
do
    pnpm install -g $package
done
