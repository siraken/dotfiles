# dotfiles

This repository manages dotfiles `.*` under `$HOME`. To use, clone this repository on `$HOME/dotfiles` and run `install`.

## Nix

Install Nix using [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

## VSCode

I'm using [VSCode Vim](https://github.com/VSCodeVim/Vim) extension to be able to use VSCode with a Vim-like keymap.
To disable `ApplePressAndHoldEnabled`, run the command below:

```bash
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## Execute PowerShell Script

```powershell
Set-ExecutionPolicy RemoteSigned
```
