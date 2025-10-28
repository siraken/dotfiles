# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Environment Setup

```bash
# Install Nix
curl --proto '=https' --tls-version=1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install nix-darwin (macOS only)
cd dotfiles
sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#darwin --impure

# Build and apply system configuration
sudo darwin-rebuild build --flake .#darwin --impure
sudo darwin-rebuild switch --flake .#darwin --impure

# For WSL/Ubuntu (home-manager only, no system-level changes)
nix run home-manager/release-25.05 -- switch --flake .#wsl-ubuntu --impure

# Garbage collection
nix store gc
```

### Development

```bash
# Format Nix files
nix fmt

# Enter development shell with formatters
nix develop
```

## Architecture

Personal dotfiles management system combining Nix and declarative configuration management.

### Flake Structure

- `flake.nix` - Main flake configuration with multiple system profiles:
  - `darwin` - Full macOS configuration (primary)
  - `darwin-min` - Minimal macOS configuration
  - `wsl-ubuntu` - WSL/Ubuntu home-manager configuration
  - `nixos` - NixOS system configuration (placeholder)

### Key Components

**System Management (macOS)**:

- `nix/hosts/darwin/configuration.nix` - System-level settings (Homebrew, macOS preferences, security)
- `nix/hosts/darwin/home.nix` - User environment configuration

**Modular Configuration**:

- `nix/modules/home-symlinks.nix` - Declarative symlink mappings for dotfiles
- `nix/modules/home-activation.nix` - Home activation scripts (runs `./symlink` for additional symlinks)
- `nix/programs/*.nix` - Individual program configurations (git, zsh, tmux, yazi, etc.)

**Symlink Management**:

- Nix home-manager handles most symlinks via `home-symlinks.nix`
- Additional symlinks (AI agents, nvim) managed by `./symlink` bash script executed during home-manager activation

### Configuration Coverage

Manages 100+ tool configurations across multiple categories:

- **Editors**: Neovim, Vim, Emacs, Helix, Kakoune
- **Shells**: Bash, Zsh, Fish
- **Terminals**: Kitty, Alacritty, WezTerm, Ghostty, Hyper
- **Window Managers**: Aerospace, Sketchybar, JankyBorders
- **Dev Tools**: Git, Tmux, Yazi, Direnv, Starship, Mise
- **AI Agents**: Claude, Gemini

### Target Architectures

- `aarch64-darwin` - Apple Silicon Macs (primary)
- `x86_64-linux` - WSL/Ubuntu and NixOS

## Important Files

- `.config/` - Application configurations (managed as symlinks)
- `.agents/` - AI agent configurations (Claude, Gemini)
- `symlink` - Bash script for non-Nix symlink management

## Git Commit Guidelines

- Write all commit messages in English
- Follow Conventional Commits format: `type(scope): description`
- Common types: feat, fix, docs, style, refactor, test, chore
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep subject line under 50 characters
- Separate subject from body with blank line if needed
