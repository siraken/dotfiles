# siraken/dotfiles

## Commands

### Environment Setup

```bash
# Install Nix
curl --proto '=https' --tls-version=1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Install nix-darwin (macOS only)
cd dotfiles
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#siraken-mbp --impure

# Build and apply system configuration
sudo darwin-rebuild build --flake .#siraken-mbp --impure
sudo darwin-rebuild switch --flake .#siraken-mbp --impure

# For WSL/Ubuntu (home-manager only, no system-level changes)
home-manager -- switch --flake .#wsl-ubuntu --impure

# For WSL/NixOS (full NixOS system configuration)
sudo nixos-rebuild switch --flake .#wsl-nixos --impure

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
  - `siraken-mbp` - Full macOS configuration (MacBook Pro, primary)
  - `siraken-macmini` - Minimal macOS configuration (Mac mini)
  - `wsl-ubuntu` - WSL/Ubuntu home-manager configuration
  - `wsl-nixos` - WSL/NixOS system configuration
  - `nixos-vm` - NixOS VM system configuration
  - `pixel10` - Android (nix-on-droid) configuration (currently commented out in flake.nix)
  - `minimal` - Lightweight home-manager profile (standalone, not registered in flake.nix)

### Key Components

**System Management (macOS)**:

- `nix/hosts/<hostname>/default.nix` - System-level settings per host (e.g., `siraken-mbp`, `siraken-macmini`)
- `nix/hosts/<hostname>/home.nix` - User environment configuration per host

**Modular Configuration**:

- `nix/programs/` - Per-program Nix modules (one `default.nix` each)
- `nix/services/` - Service modules (e.g. `darwin/aerospace.nix`, `darwin/sketchybar/`, `tailscale.nix`)
- `nix/home/` - Standalone home-manager profiles (e.g. `wsl-ubuntu`, `minimal`)
- `nix/modules/` - Shared modules (aliases, nixpkgs, shells, paths, variables, darwin common, home common, mk-repo-link)
- `config/` - Native config files mirroring `~/.config` (e.g. `config/ghostty/config`, `config/nano/nanorc`)
- `home/` - Native config files mirroring `~` for non-XDG paths (e.g. `home/.ideavimrc`)

**Code Quality**:

- treefmt-nix with flake-parts module for multi-language formatting (nixfmt, stylua, shfmt, biome, yamlfmt, mdformat, fish_indent)
- git-hooks.nix for pre-commit hook that runs treefmt on staged files

**Symlink Management**:

- Native config files in `config/` and `home/` are linked into place as **out-of-store symlinks** via the shared `mkRepoLink` helper (`nix/modules/home/mk-repo-link.nix`), so they are editable in place without a rebuild (assumes the repo is checked out at `~/dotfiles`).
- Tools whose generated file is owned by home-manager pull the repo file in instead of being replaced wholesale: ghostty `config-file`, kitty `include`, tmux `source-file`, git `includes`, shells `source`, emacs `load-file`.
- Host-varying / generated bits stay in Nix (identity & signing, gpg, font-size, tmux plugins/shell, lib-generated ignores, shell integration).
- nixvim and shell-integration tools (atuin, direnv, starship, etc.) remain fully Nix-managed.

### Configuration Coverage

Manages 40+ tool configurations across multiple categories:

- **Editors**: Neovim (via [Nixvim](https://github.com/nix-community/nixvim)), Vim, Emacs, Helix, Zed
- **IDEs**: VS Code, IntelliJ IDEA
- **Shells**: Bash, Zsh, Fish
- **Terminals**: Kitty, WezTerm, Ghostty
- **Window Managers**: AeroSpace, Sketchybar, JankyBorders
- **Dev Tools**: Git, GitUI, Tmux, Zellij, Yazi, Direnv, Starship, Mise, Difftastic, Fzf, gh-dash, Lazydocker, Bat, Bottom, Fastfetch, Zoxide, AWS CLI
- **Security**: 1Password Shell Plugins
- **Media**: Spotify-player, Twitch-TUI, yt-dlp, Neovide
- **AI Agents**: Claude Code, Antigravity CLI, Codex, OpenCode, APM
- **Networking**: Tailscale

### Target Architectures

- `aarch64-darwin` - Apple Silicon Macs (primary)
- `x86_64-linux` - WSL/Ubuntu and NixOS
- `aarch64-linux` - Android (nix-on-droid, pixel10)

## Important Files

- `nix/programs/` - Per-program Nix modules (one `default.nix` each)
- `config/` - Native config files mirroring `~/.config` (out-of-store linked)
- `home/` - Native config files mirroring `~` for non-XDG paths (e.g. `home/.ideavimrc`, `home/.claude/settings.json`)
- `nix/programs/coding-agents/` - Coding agent configurations (Claude Code, Antigravity CLI, Codex, OpenCode, APM)

## Git Commit Guidelines

- Write all commit messages in English
- Follow Conventional Commits format: `type(scope): description`
- Common types: feat, fix, docs, style, refactor, test, chore
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep subject line under 50 characters
- Separate subject from body with blank line if needed

## Agent Rules

### Command Execution

- **Never pipe nix-darwin or home-manager commands**: Commands like `darwin-rebuild`, `home-manager switch`, and `home-manager/...` must NOT be piped to other commands. Piping causes these commands to terminate prematurely without completing properly.

```bash
# Bad - Do NOT do this
darwin-rebuild switch --flake .#siraken-mbp --impure | tee output.log
home-manager switch --flake .#wsl-ubuntu --impure | cat

# Good - Run commands directly
darwin-rebuild switch --flake .#siraken-mbp --impure
home-manager switch --flake .#wsl-ubuntu --impure
```
