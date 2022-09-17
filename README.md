# dotfiles

This repository manages dotfiles `.*` under `$HOME`.

Clone this repository on `$HOME/dotfiles` and run an executable file `install`.

## Packages

### Shell

- [Zsh](https://zsh.org/)
  - [Oh My Zsh](https://ohmyz.sh/)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [agkozak/zsh-z](https://github.com/agkozak/zsh-z)
  - [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [fish](https://fishshell.com/)
  - [fisher](https://github.com/jorgebucaran/fisher)
  - [IlanCosman/tide](https://github.com/IlanCosman/tide)
- [Starship](https://starship.rs/)

### Neovim

Configuration files are written in Lua.

- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)

## Try on Ubuntu on Docker

```bash
docker run -w /root -it --rm ubuntu:22.04 sh -uelic '
    apt-get update -y && apt-get upgrade -y && apt-get install -y git sudo
    git clone https://github.com/SiraKen/dotfiles ~/dotfiles
    cd ~/dotfiles && ./install && cd ./setup/linux && ./apt-install
    cd ../ && ./install-reqs
    apt-get install -y nodejs
    nvim --headless +PackerInstall +q
    fish
'
```
