# dotfiles

[![Open in Visual Studio Code](https://img.shields.io/static/v1?logo=visualstudiocode&label=&message=Open%20in%20Visual%20Studio%20Code&labelColor=2c2c32&color=007acc&logoColor=007acc)](https://open.vscode.dev/siraken/dotfiles)

This repository manages dotfiles `.*` under `$HOME`.
Clone this repository on `$HOME/dotfiles` and run `install`.

## Packages

<!--
### [Home Manager](https://github.com/nix-community/home-manager)

This manages my development environment using [Nix](https://nixos.org/).

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Install Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Install home-manager packages
nix-shell '<home-manager>' -A install

# Switch to home-manager configuration (-f option is optional)
home-manager switch -f /path/to/nix-file.nix
```
-->

### Shell

- [fish shell](https://fishshell.com/)
- [Starship](https://starship.rs/)

### Neovim

Configuration files are written in Lua.
I'm using [LazyVim](https://www.lazyvim.org/) for my base setup.

### VSCode

I'm using [VSCode Vim](https://github.com/VSCodeVim/Vim) extension to be able to use VSCode with a Vim-like keymap.
To disable `ApplePressAndHoldEnabled`, run the command below:

```bash
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

### Execute PowerShell Script

```powershell
Set-ExecutionPolicy RemoteSigned
```
