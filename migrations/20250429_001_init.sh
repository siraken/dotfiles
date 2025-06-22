#!/bin/sh

EXECUTION_PATH=$(cd $(dirname $0); pwd)
source "$EXECUTION_PATH/__setup__"

ACTION=$1

case $ACTION in
up)
  # NOTE: All symlinks including Claude config are now managed by home-manager
  # Run: darwin-rebuild switch --flake .#mbp
  
  printf "\e[1;33mInfo:\e[m All symlinks including Claude config are now managed by home-manager.\n"
  printf "\e[1;33mInfo:\e[m To apply configuration, run: \e[36mdarwin-rebuild switch --flake .#mbp\e[m\n"
;;
down)
  printf "\e[1;33mInfo:\e[m All symlinks including Claude config are managed by home-manager.\n"
  printf "\e[1;33mInfo:\e[m To remove configuration, run home-manager with empty config.\n"
;;
esac
