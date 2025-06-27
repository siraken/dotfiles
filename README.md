# dotfiles

~~This repository manages dotfiles `.*` under `$HOME`. To use, clone this repository on `$HOME/dotfiles` and run `install`.~~

## Installation

### 1. Clone this repository

```bash
git clone https://github.com/siraken/dotfiles.git
```

### 2. Install Nix

Install Nix using [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

If the installer prompts you to install Determinate Nix, select `no` to install Nix from NixOS instead.

```
INFO nix-installer v3.4.1
INFO For a more robust Nix installation, use the Determinate package for macOS: https://dtr.mn/determinate-nix

Install Determinate Nix?

Selecting 'no' will install Nix from NixOS instead.

Proceed? ([Y]es/[n]o/[e]xplain):
```

To uninstall Nix, run the command below:

```bash
/nix/nix-installer uninstall
```

### 3. Install `nix-darwin`

```bash
cd dotfiles
nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .
```

After the installation, you may need to restart your terminal. The `darwin-*` commands are available in your shell.

## 4. Run `darwin-rebuild`

```bash
# Build darwin flake using:
sudo darwin-rebuild build --flake .#THE_NAME --impure
sudo darwin-rebuild switch --flake .#THE_NAME --impure

# ex)
sudo darwin-rebuild build --flake .#mbp --impure
```

## x. Garbage Collection

```bash
nix store gc
```
