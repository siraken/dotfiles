# dotfiles

[![Open in Visual Studio Code](https://img.shields.io/static/v1?logo=visualstudiocode&label=&message=Open%20in%20Visual%20Studio%20Code&labelColor=2c2c32&color=007acc&logoColor=007acc)](https://open.vscode.dev/siraken/dotfiles)

This repository manages dotfiles `.*` under `$HOME`.
Clone this repository on `$HOME/dotfiles` and run `install`.

[siraken/installer](https://github.com/siraken/installer) repo is required to work this repository properly.

Minimized `dotfiles`: [siraken/dotfiles-min](https://github.com/siraken/dotfiles-min)

## Packages

### Shells

-   [fish shell](https://fishshell.com/)
    -   [fisher](https://github.com/jorgebucaran/fisher)
    -   [jethrokuan/z](https://github.com/jethrokuan/z)
-   [Nushell](https://www.nushell.sh/)
-   [Starship](https://starship.rs/)

### Neovim

Configuration files are written in Lua.
I'm using [folke/lazy.nvim](https://github.com/folke/lazy.nvim) as a package manager.

### VSCode

I'm using an extension called [VSCode Vim](https://github.com/VSCodeVim/Vim), to be able to use VSCode with a Vim-like keymap.
To disable `ApplePressAndHoldEnabled`, run the command below:

```bash
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## Try on Docker

### Ubuntu 22.04

```bash
docker run -w /root -it --rm ubuntu:22.04 sh -uelic '
    apt-get update -y && apt-get upgrade -y && apt-get install -y git sudo
    git clone https://github.com/siraken/dotfiles ~/dotfiles
    git clone https://github.com/siraken/installer ~/installer
    cd ~/dotfiles && ./install
    cd ~/installer/linux && ./apt.sh
    cd ~/installer/tools && ./install-reqs.sh
    apt-get install -y nodejs
    nvim --headless +PackerInstall +q
    cd ~/ && fish
'
```

### Arch Linux

```bash
docker run -w /root -it --platform linux/x86_64 --rm archlinux:latest sh -uelic '
    pacman -Syyu --noconfirm
    pacman -S --noconfirm git sudo
    git clone https://github.com/siraken/dotfiles ~/dotfiles
    git clone https://github.com/siraken/installer ~/installer
    cd ~/dotfiles && ./install
    cd ~/installer/linux && ./pacman.sh
    cd ~/installer/tools && ./install-reqs.sh
    cd ~/ && fish
'
```
