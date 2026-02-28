# dotfiles

## Usage

### Initial Setup

1. Install [Determinate Nix](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

2. Clone this repository:

```sh
git clone --depth 1 \
  https://github.com/siraken/dotfiles.git \
  ~/repos/github.com/siraken/dotfiles
```

3. Install `nix-darwin`

```bash
cd dotfiles
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#siraken-mbp --impure
```

After the installation, you may need to restart your terminal. The `darwin-*` commands are available in your shell.

4. Run `darwin-rebuild` or `home-manager`

```bash
# Build darwin flake using:
sudo darwin-rebuild build --flake .#THE_NAME --impure
sudo darwin-rebuild switch --flake .#THE_NAME --impure

# ex)
sudo darwin-rebuild switch --flake .#siraken-mbp --impure
```

or

```bash
home-manager -- switch --flake .#THE_NAME --impure

# ex)
home-manager -- switch --flake .#wsl-ubuntu --impure
```

### Development

```bash
# Format all files (Nix, Lua, Shell, JSON, YAML, Markdown, Fish)
nix fmt

# Enter development shell (also installs pre-commit hooks)
nix develop
```

### Uninstall

To uninstall Nix, run the command below:

```bash
/nix/nix-installer uninstall
```

### Garbage Collection

```bash
nix store gc
```
