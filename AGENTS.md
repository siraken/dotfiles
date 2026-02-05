# siraken/dotfiles

## Commands

### Environment Setup

```bash
# Install Nix
curl --proto '=https' --tls-version=1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install nix-darwin (macOS only)
cd dotfiles
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#darwin --impure

# Build and apply system configuration
sudo darwin-rebuild build --flake .#darwin --impure
sudo darwin-rebuild switch --flake .#darwin --impure

# For WSL/Ubuntu (home-manager only, no system-level changes)
nix run home-manager -- switch --flake .#wsl-ubuntu --impure

# Garbage collection
nix store gc
```

### Development

```bash
# Format all files (Nix, Lua, Shell, JSON, YAML, Markdown, Fish)
nix fmt

# Enter development shell (also installs pre-commit hooks via git-hooks.nix)
nix develop
```

## Architecture

Personal dotfiles management system combining Nix and declarative configuration management.

### Flake Structure

- `flake.nix` - Main flake configuration using flake-parts with multiple system profiles:
  - `darwin` - Full macOS configuration (primary)
  - `darwin-min` - Minimal macOS configuration
  - `wsl-ubuntu` - WSL/Ubuntu home-manager configuration
  - `nixos` - NixOS system configuration (placeholder)

### Key Components

**System Management (macOS)**:

- `nix/hosts/darwin/configuration.nix` - System-level settings (Homebrew, macOS preferences, security)
- `nix/hosts/darwin/home.nix` - User environment configuration

**Modular Configuration**:

- `nix/programs/` - Individual program configurations with colocated config files (git, zsh, tmux, yazi, etc.)

**Code Quality**:

- treefmt-nix with flake-parts module for multi-language formatting (nixfmt, stylua, shfmt, biome, yamlfmt, mdformat, fish_indent)
- git-hooks.nix for pre-commit hook that runs treefmt on staged files

**Symlink Management**:

- Immutable symlinks are managed by home-manager via `home.file` in each program module (copied to Nix store)
- Mutable symlinks (AI agents, nvim, wezterm) are created via `home.activation` scripts using `config/` subdirectories for direct file access

### Configuration Coverage

Manages 100+ tool configurations across multiple categories:

- **Editors**: Neovim, Vim, Emacs, Helix
- **Shells**: Bash, Zsh, Fish
- **Terminals**: Kitty, Alacritty, WezTerm, Ghostty, Hyper
- **Window Managers**: AeroSpace, Sketchybar, JankyBorders
- **Dev Tools**: Git, Tmux, Yazi, Direnv, Starship, Mise
- **AI Agents**: Claude, Gemini

### Target Architectures

- `aarch64-darwin` - Apple Silicon Macs (primary)
- `x86_64-linux` - WSL/Ubuntu and NixOS

## Important Files

- `nix/programs/` - Program modules with colocated config files (e.g., `nix/programs/nvim/config/`, `nix/programs/wezterm/config/`)
- `.agents/` - AI agent configurations (Claude, Gemini)

## Git Commit Guidelines

- Write all commit messages in English
- Follow Conventional Commits format: `type(scope): description`
- Common types: feat, fix, docs, style, refactor, test, chore
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep subject line under 50 characters
- Separate subject from body with blank line if needed

## Agent Rules

### Command Execution

- **Never pipe nix-darwin or home-manager commands**: Commands like `darwin-rebuild`, `home-manager switch`, and `nix run home-manager/...` must NOT be piped to other commands. Piping causes these commands to terminate prematurely without completing properly.

```bash
# Bad - Do NOT do this
darwin-rebuild switch --flake .#darwin --impure | tee output.log
home-manager switch --flake .#wsl-ubuntu --impure | cat

# Good - Run commands directly
darwin-rebuild switch --flake .#darwin --impure
home-manager switch --flake .#wsl-ubuntu --impure
```
