#!/bin/sh

EXECUTION_PATH=$(cd $(dirname $0); pwd)
source "$EXECUTION_PATH/__setup__"

ACTION=$1

case $ACTION in
up)
  # NOTE: Symlinks are now managed by home-manager
  # Run: darwin-rebuild switch --flake .#mbp
  
  printf "\e[1;33mInfo:\e[m Symlinks are now managed by home-manager.\n"
  printf "\e[1;33mInfo:\e[m To apply configuration, run: \e[36mdarwin-rebuild switch --flake .#mbp\e[m\n"
  
  # Only create Claude config directory and symlinks (not managed by home-manager)
  mkdir -p ~/.claude
  
  INSTALL Claude
  ln -snf ~/dotfiles/.config/claude/commands ~/.claude/commands
  ln -snf ~/dotfiles/.config/claude/settings.json ~/.claude/settings.json
  ln -snf ~/dotfiles/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
;;
down)
  printf "\e[1;33mInfo:\e[m Most symlinks are managed by home-manager.\n"
  printf "\e[1;33mInfo:\e[m To remove configuration, run home-manager with empty config.\n"
  
  # Remove Claude config (not managed by home-manager)
  rm -rf ~/.claude
;;
esac
