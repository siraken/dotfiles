#!/bin/bash

bun_packages=(
  "typescript"
  "nativescript"
  "@ionic/cli"
  "native-run"
  "source-map-support"
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
  "@anthropic-ai/claude-code"
  "web-push"
)

npm_packages=(
  "purescript"
  "spago"
)

printf "Installing npm packages using bun..."

for package in "${bun_packages[@]}"; do
  bun add -g $package
done

printf "Installing npm packages using npm..."

for package in "${npm_packages[@]}"; do
  npm install -g $package
done
