#!/bin/bash

packages=(
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
  "purescript"
  "spago"
)

# Install packages
printf "Installing npm packages using pnpm..."

for package in "${packages[@]}"; do
  bun add -g $package
done
