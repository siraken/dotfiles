#!/bin/bash

bun_pkgs=(
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

npm_pkgs=(
  "purescript"
  "spago"
)

printf "Installing bun packages..."

for pkg in "${bun_pkgs[@]}"; do
  bun add -g $pkg
done

printf "Installing npm packages..."

for pkg in "${npm_pkgs[@]}"; do
  npm install -g $pkg
done
