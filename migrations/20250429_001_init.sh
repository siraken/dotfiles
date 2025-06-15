#!/bin/sh

EXECUTION_PATH=$(cd $(dirname $0); pwd)
source "$EXECUTION_PATH/__setup__"

ACTION=$1

case $ACTION in
up)
  mkdir -p ~/.config

  INSTALL hammerspoon
  ln -snf ~/dotfiles/.hammerspoon ~/

  INSTALL kitty
  ln -snf ~/dotfiles/.config/kitty ~/.config/

  INSTALL bash
  ln -snf ~/dotfiles/.config/bash/.bash_profile ~/.bash_profile
  ln -snf ~/dotfiles/.config/bash ~/.config/

  INSTALL zsh
  ln -snf ~/dotfiles/.config/zsh ~/.config/zsh
  ln -snf ~/dotfiles/.config/zsh/.zprofile ~/.zprofile
  ln -snf ~/dotfiles/.config/zsh/.zshrc ~/.zshrc

  INSTALL fish
  ln -snf ~/dotfiles/.config/fish ~/.config/

  INSTALL husky
  ln -snf ~/dotfiles/.config/husky ~/.config/

  INSTALL simple-bar
  ln -snf ~/dotfiles/.config/simple-bar/.simplebarrc ~/.simplebarrc

  INSTALL mise
  ln -snf ~/dotfiles/.config/mise ~/.config/

  INSTALL ranger
  ln -snf ~/dotfiles/.config/ranger ~/.config/

  INSTALL tmux
  ln -snf ~/dotfiles/.config/tmux ~/.config/

  INSTALL Starship
  ln -snf ~/dotfiles/.config/starship.toml ~/.config/starship.toml

  INSTALL Git
  ln -snf ~/dotfiles/.config/git ~/.config/
  ln -snf ~/dotfiles/.config/git/conf.d/os/macos.conf ~/.config/git/conf.d/credential.conf

  INSTALL Emacs
  ln -snf ~/dotfiles/.config/emacs ~/.config/

  INSTALL nano
  ln -snf ~/dotfiles/.config/nano ~/.config/

  INSTALL Vim
  ln -snf ~/dotfiles/.config/vim/.vimrc ~/.vimrc

  INSTALL IdeaVim
  ln -snf ~/dotfiles/.config/idea/.ideavimrc ~/.ideavimrc

  INSTALL Neovim
  ln -snf ~/dotfiles/.config/nvim ~/.config/

  INSTALL Neovide
  ln -snf ~/dotfiles/.config/neovide ~/.config/

  INSTALL Helix
  ln -snf ~/dotfiles/.config/helix ~/.config/

  INSTALL Kakoune
  ln -snf ~/dotfiles/.config/kak ~/.config/

  INSTALL Zed
  ln -snf ~/dotfiles/.config/zed/settings.json ~/.config/zed/settings.json

  INSTALL MongoDB Shell
  ln -snf ~/dotfiles/.mongoshrc.js ~/.mongoshrc.js

  INSTALL PowerShell
  mkdir -p ~/.config/powershell
  ln -snf ~/dotfiles/.config/powershell/linux.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1

  INSTALL Hyper
  ln -snf ~/dotfiles/.config/hyper/.hyper.js ~/.hyper.js

  INSTALL .vsnip
  ln -snf ~/dotfiles/.vsnip ~/.vsnip

  INSTALL Alacritty
  ln -snf ~/dotfiles/.config/alacritty ~/.config

  INSTALL WezTerm
  ln -snf ~/dotfiles/.config/wezterm ~/.config

  INSTALL Ghostty
  ln -snf ~/dotfiles/.config/ghostty ~/.config

  INSTALL yt-dlp
  ln -snf ~/dotfiles/.config/yt-dlp ~/.config

  INSTALL nano
  ln -snf ~/dotfiles/.config/bat ~/.config/

  INSTALL Sketchybar
  ln -snf ~/dotfiles/.config/sketchybar ~/.config

  INSTALL JankyBorders
  ln -snf ~/dotfiles/.config/borders ~/.config

  INSTALL Claude
  ln -snf ~/dotfiles/.config/claude/commands ~/.claude

  # INSTALL nix
  # ln -snf ~/dotfiles/.config/nix ~/.config
;;
down)
  rm -rf ~/.hammerspoon
  rm -rf ~/.config/kitty
  rm -rf ~/.bashrc
  rm -rf ~/.zprofile
  rm -rf ~/.zshrc
  rm -rf ~/.config/fish
  rm -rf ~/.simplebarrc
  rm -rf ~/.config/ranger
  rm -rf ~/.tmux.conf
  rm -rf ~/.tmux.darwin.conf
  rm -rf ~/.tmux.powerline.conf
  rm -rf ~/.config/starship.toml
  rm -rf ~/.config/git
  rm -rf ~/.emacs.d
  rm -rf ~/.spacemacs.d
  rm -rf ~/.config/nano
  rm -rf ~/.vimrc
  rm -rf ~/.config/nvim
  rm -rf ~/.config/helix
  rm -rf ~/.config/kak
  rm -rf ~/.mongoshrc.js
  rm -rf ~/.config/powershell/Microsoft.PowerShell_profile.ps1
  rm -rf ~/.hyper.js
;;
esac
