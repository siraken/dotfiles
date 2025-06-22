# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Environment Setup

```bash
# Install Nix
curl --proto '=https' --tls-version=1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install nix-darwin
nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .

# Build and apply system configuration (includes dotfiles symlinks)
sudo darwin-rebuild build --flake .#mbp
sudo darwin-rebuild switch --flake .#mbp

# Garbage collection
nix store gc
```

### Dotfiles Management

```bash
# Create additional symlinks (Claude config only)
./install up

# Remove additional symlinks
./install down

# Note: Most dotfiles are now managed by home-manager
# Use darwin-rebuild to apply dotfiles changes
```

## Architecture

Personal dotfiles management system combining Nix and migration system:

### Nix System Management
- `flake.nix` - Nix flake configuration, integrates nix-darwin and home-manager
- `nix/darwin.nix` - macOS-specific settings (Homebrew, system preferences, security)
- `nix/home.nix` - User environment configuration
- Target architecture: arm64-darwin (Apple Silicon Mac)

### Migration Management System
- `install` - Migration execution script
- `migrations/` - Configuration file symlink creation scripts
- `migrations/__setup__` - Common migration functions
- Creates symlinks for config files in `~/.config/` and `~/`

### Configuration Coverage
Manages 100+ tool configurations including Neovim, Git, shells (Bash/Zsh/Fish), terminals (Kitty/Alacritty/WezTerm), editors (Vim/Emacs/Helix), window managers (Yabai/Sketchybar)

## Git Commit Guidelines

- Write all commit messages in English
- Follow Conventional Commits format: `type(scope): description`
- Common types: feat, fix, docs, style, refactor, test, chore
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep subject line under 50 characters
- Separate subject from body with blank line if needed