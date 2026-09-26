# siraken/dotfiles

## Commands

### Environment Setup

```bash
# Install Nix
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes

# The OS layer (nix-darwin / NixOS) and the user environment (standalone
# home-manager) are applied separately, OS first.

# Install nix-darwin (macOS only)
cd dotfiles
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#siraken-mbp

# macOS: both layers at once (`nix run .#macmini` for the Mac mini)
nix run .#mbp

# macOS: one layer at a time
sudo darwin-rebuild switch --flake .#siraken-mbp
home-manager switch -b hm-backup --flake .#siraken@siraken-mbp

# NixOS (wsl-nixos, nixos-vm)
sudo nixos-rebuild switch --flake .#wsl-nixos
home-manager switch -b hm-backup --flake .#siraken@wsl-nixos

# First run on a host without the home-manager CLI yet
nix run home-manager/master -- switch -b hm-backup --flake .#siraken@wsl-nixos

# For WSL/Ubuntu (home-manager only, no system-level changes)
home-manager switch -b hm-backup --flake .#siraken@wsl-ubuntu

# Any other host, without cloning (generic profile: base / standard / full)
nix run home-manager/master -- switch --flake github:siraken/dotfiles#siraken@base-x86_64-linux

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
  - `siraken@<host>` / `siraken@<profile>-<system>` - standalone home-manager configurations (see `nix/home/default.nix`)
  - `wsl-nixos` - WSL/NixOS system configuration
  - `nixos-vm` - NixOS VM system configuration
  - `pixel10` - Android (nix-on-droid) configuration (currently commented out in flake.nix)

### Key Components

**System Management (macOS)**:

- `nix/hosts/<hostname>/default.nix` - System-level settings per host (e.g., `siraken-mbp`, `siraken-macmini`)
- `nix/hosts/<hostname>/home.nix` - User environment configuration per host

**Modular Configuration**:

- `nix/programs/` - Per-program Nix modules (one `default.nix` each)
- `nix/services/` - Service modules. Everything under `nix/services/darwin/` (AeroSpace, JankyBorders, Sketchybar) is a nix-darwin module imported by `nix/modules/darwin/workstation.nix`; home-manager never manages the window manager.
- `nix/home/profiles/` - Layered home-manager profiles: `base` (production / SSH-only hosts) ⊂ `standard` ⊂ `full` (daily drivers), plus `darwin` (macOS-only additions). Hosts import one of them instead of listing programs.
- `nix/home/default.nix` - Registry of every standalone home-manager configuration: `siraken@<host>` for known hosts and `siraken@<profile>-<system>` for generic ones, all built with `nix/lib/mk-home.nix`. nix-darwin / NixOS hosts do not embed home-manager; their user environment is always this standalone entry.
- `nix/home/<name>/` - Home module of a host that has no system configuration here (e.g. `wsl-ubuntu`)
- `nix/lib/` - Configuration builders: `mk-darwin-host.nix`, `mk-nixos-host.nix`, `mk-home.nix` (standalone home-manager)
- `nix/modules/` - Shared modules: `packages.nix` and `aliases.nix` (split into `base` / `standard` / `full` tiers, each consumed by the matching profile), shells, paths, variables, binary caches (`nix-cache-list.nix`, used by both the OS-level `nix-caches.nix` and `home/nix-caches.nix`), `darwin/base.nix` (every Mac: nix, SSH, no sleep) and `darwin/workstation.nix` (a Mac you sit in front of: macOS defaults, keyboard, fonts, window manager), `home/nixos-host.nix` (what home-manager used to inherit from NixOS), mk-repo-link. nix-index + comma belong to the `standard` home-manager profile, not the OS layer.
- `config/` - Native config files mirroring `~/.config` (e.g. `config/ghostty/config`, `config/nano/nanorc`)
- `home/` - Native config files mirroring `~` for non-XDG paths (e.g. `home/.claude/settings.json`)

**Code Quality**:

- treefmt-nix with flake-parts module for multi-language formatting (nixfmt, stylua, shfmt, biome, yamlfmt, mdformat, fish_indent)
- git-hooks.nix for pre-commit hook that runs treefmt on staged files

**Symlink Management**:

- Native config files in `config/` and `home/` are linked into place via the shared `mkRepoLink` helper (`nix/modules/home/mk-repo-link.nix`). Where they point is set by `dotfiles.linkMode`:
  - `outOfStore` (set by the `full` profile): symlinks into the checkout at `~/dotfiles`, editable in place without a rebuild.
  - `store` (the default, used by `base` / `standard`): the copy of the flake source in the Nix store, so a host can apply the flake straight from GitHub without cloning it.
- Tools whose generated file is owned by home-manager pull the repo file in instead of being replaced wholesale: ghostty `config-file`, kitty `include`, tmux `source-file`, git `includes`, shells `source`, emacs `load-file`, vim `source`. They take the path from the `repoPath` helper, never a hard-coded `~/dotfiles/...`, so they follow `dotfiles.linkMode` too.
- Host-varying / generated bits stay in Nix (identity & signing, gpg, font-size, tmux plugins/shell, lib-generated ignores, shell integration).
- nixvim and shell-integration tools (atuin, direnv, starship, etc.) remain fully Nix-managed.

**Per-persona git config (`secrets.toml`)**:

- The mechanism itself lives in [git-personas.nix](https://github.com/siraken/git-personas.nix), a flake input exposing a home-manager module. `nix/programs/git/default.nix` only imports it and sets `programs.gitPersonas.personasFile`; do not add generator scripts back here.
- `secrets.toml` (git-ignored, schema in `secrets.example.toml`) lists `gitPersonas` entries of `{ dir, configFile }` plus the optional `credentialHosts` and `env`. The file is TOML; JSON is not accepted.
- It is **never read during evaluation**. Activation scripts regenerate `~/.config/git.custom/personas.gitconfig` and the per-persona `.envrc` files on every switch; the generated include is appended with `mkAfter` so persona overrides win over the shared config — git ignores a missing include path.
- `credentialHosts` empties the credential helper list for those hosts globally, and the per-persona body puts it back, so a stored token is reachable only from `~/repos/<dir>/`. Cloning *into* that directory still works (git re-reads its config once the repository exists); cloning from anywhere else prompts.
- `env` is written to `~/repos/<dir>/.envrc` for tools that key off a host, such as `GITLAB_HOST` for glab. An `.envrc` the module did not write is never overwritten.
- Evaluation therefore stays pure: **no `--impure` flag is needed anywhere**. Do not reintroduce `builtins.readFile` / `builtins.pathExists` on paths outside the flake; under pure evaluation they fail silently and produce a different system than the one CI checked.
- The per-persona bodies (`~/.config/git.custom/<configFile>`) are maintained by hand outside the repo.

### Configuration Coverage

Manages 40+ tool configurations across multiple categories:

- **Editors**: Neovim (via [Nixvim](https://github.com/nix-community/nixvim)), Vim, Emacs, Helix, Zed
- **IDEs**: VS Code
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
- `home/` - Native config files mirroring `~` for non-XDG paths (e.g. `home/.claude/settings.json`)
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
darwin-rebuild switch --flake .#siraken-mbp | tee output.log
home-manager switch --flake .#siraken@wsl-ubuntu | cat

# Good - Run commands directly
darwin-rebuild switch --flake .#siraken-mbp
home-manager switch --flake .#siraken@wsl-ubuntu
```
