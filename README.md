# dotfiles

This repository manages dotfiles `.*` under `$HOME`. To use, clone this repository on `$HOME/dotfiles` and run `install`.

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
