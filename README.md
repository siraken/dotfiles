<h1 align="center">dotfiles</h1>

<p align="center">
  <b>Declarative, reproducible system configuration powered by Nix</b>
</p>

<p align="center">
  <a href="https://nixos.org"><img src="https://img.shields.io/badge/Nix-flakes-blue?logo=nixos&logoColor=white" alt="Nix Flakes"></a>
  <a href="https://github.com/nix-darwin/nix-darwin"><img src="https://img.shields.io/badge/nix--darwin-macOS-black?logo=apple&logoColor=white" alt="nix-darwin"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/home--manager-latest-green?logo=nixos&logoColor=white" alt="home-manager"></a>
  <img src="https://img.shields.io/badge/platform-aarch64--darwin%20%7C%20x86__64--linux-lightgrey" alt="Platform">
</p>

______________________________________________________________________

## Overview

Personal dotfiles management system combining [Nix Flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager) for fully declarative and reproducible environments across macOS and Linux.

### System Profiles

| Profile | Platform | Type | Description |
| --- | --- | --- | --- |
| `siraken-mbp` | macOS (aarch64) | nix-darwin | MacBook Pro — full configuration (primary) |
| `siraken-macmini` | macOS (aarch64) | nix-darwin | Mac mini — minimal configuration |
| `wsl-ubuntu` | Linux (x86_64) | home-manager | WSL/Ubuntu — user environment only |
| `wsl-nixos` | Linux (x86_64) | NixOS | WSL/NixOS — full system configuration |
| `nixos-vm` | Linux (x86_64) | NixOS | NixOS VM — virtual machine |

### Key Features

- **Multi-platform** — Single flake manages macOS (nix-darwin) and Linux (NixOS / home-manager)
- **Modular** — Each program is an independent Nix module under `nix/programs/`
- **Reproducible** — Pinned inputs via `flake.lock` ensure consistent builds
- **Formatted** — [treefmt-nix](https://github.com/numtide/treefmt-nix) with pre-commit hooks (nixfmt, stylua, shfmt, biome, yamlfmt, mdformat, fish_indent)

## Getting Started

### Prerequisites

Install [Determinate Nix](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### Installation

<details>
<summary><b>macOS (nix-darwin)</b></summary>

```bash
# Clone
git clone --depth 1 \
  https://github.com/siraken/dotfiles.git \
  ~/repos/github.com/siraken/dotfiles
cd ~/repos/github.com/siraken/dotfiles

# First-time install
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#THE_NAME --impure

# After initial setup
sudo darwin-rebuild switch --flake .#THE_NAME --impure
```

</details>

<details>
<summary><b>WSL/Ubuntu (home-manager)</b></summary>

```bash
home-manager -- switch --flake .#wsl-ubuntu --impure
```

</details>

<details>
<summary><b>WSL/NixOS</b></summary>

```bash
sudo nixos-rebuild switch --flake .#wsl-nixos --impure
```

</details>

### Development

```bash
# Enter development shell (also installs pre-commit hooks)
nix develop

# Format all files
nix fmt
```

### Maintenance

```bash
# Garbage collection
nix store gc

# Uninstall Nix
/nix/nix-installer uninstall
```

## Configuration

All program configurations are managed as Nix modules under [`nix/programs/`](nix/programs/).

### Editors

| Program | Module Path | Notes |
| --- | --- | --- |
| Neovim | [`nix/programs/vim/`](nix/programs/vim/) | Configured via [Nixvim](https://github.com/nix-community/nixvim) |
| Vim | [`nix/programs/vim/`](nix/programs/vim/) | Shares module with Neovim |
| Emacs | [`nix/programs/emacs/`](nix/programs/emacs/) | |
| Helix | [`nix/programs/helix/`](nix/programs/helix/) | |
| Neovide | [`nix/programs/neovide/`](nix/programs/neovide/) | Neovim GUI frontend |
| VS Code | [`nix/programs/vscode/`](nix/programs/vscode/) | |
| IntelliJ IDEA | [`nix/programs/idea/`](nix/programs/idea/) | |

### Shells

| Program | Module Path |
| --- | --- |
| Bash | [`nix/programs/bash/`](nix/programs/bash/) |
| Zsh | [`nix/programs/zsh/`](nix/programs/zsh/) |
| Fish | [`nix/programs/fish/`](nix/programs/fish/) |

### Terminals

| Program | Module Path |
| --- | --- |
| Kitty | [`nix/programs/kitty/`](nix/programs/kitty/) |
| WezTerm | [`nix/programs/wezterm/`](nix/programs/wezterm/) |
| Ghostty | [`nix/programs/ghostty/`](nix/programs/ghostty/) |

### Dev Tools

| Program | Module Path | Notes |
| --- | --- | --- |
| Git | [`nix/programs/git/`](nix/programs/git/) | |
| Tmux | [`nix/programs/tmux/`](nix/programs/tmux/) | |
| Zellij | [`nix/programs/zellij/`](nix/programs/zellij/) | |
| Yazi | [`nix/programs/yazi/`](nix/programs/yazi/) | File manager |
| Direnv | [`nix/programs/direnv/`](nix/programs/direnv/) | |
| Starship | [`nix/programs/starship/`](nix/programs/starship/) | Prompt |
| Mise | [`nix/programs/mise/`](nix/programs/mise/) | Runtime version manager |
| fzf | [`nix/programs/fzf/`](nix/programs/fzf/) | |
| Zoxide | [`nix/programs/zoxide/`](nix/programs/zoxide/) | |
| bat | [`nix/programs/bat/`](nix/programs/bat/) | |
| Difftastic | [`nix/programs/difftastic/`](nix/programs/difftastic/) | Structural diff |
| bottom | [`nix/programs/bottom/`](nix/programs/bottom/) | System monitor |
| Atuin | [`nix/programs/atuin/`](nix/programs/atuin/) | Shell history |
| GitUI | [`nix/programs/gitui/`](nix/programs/gitui/) | |
| gh-dash | [`nix/programs/gh-dash/`](nix/programs/gh-dash/) | GitHub dashboard |
| Lazydocker | [`nix/programs/lazydocker/`](nix/programs/lazydocker/) | |
| fastfetch | [`nix/programs/fastfetch/`](nix/programs/fastfetch/) | |

### AI Agents

| Program | Module Path |
| --- | --- |
| Claude, Gemini, Codex, OpenCode | [`nix/programs/coding-agents/`](nix/programs/coding-agents/) |

## Project Structure

```
dotfiles/
├── flake.nix                  # Flake entry point
├── flake.lock                 # Pinned dependencies
├── nix/
│   ├── hosts/                 # Per-host system configurations
│   │   ├── siraken-mbp/       #   MacBook Pro
│   │   ├── siraken-macmini/   #   Mac mini
│   │   ├── wsl-nixos/         #   WSL/NixOS
│   │   └── nixos-vm/          #   NixOS VM
│   ├── home/                  # Per-host home-manager configurations
│   │   └── wsl-ubuntu/        #   WSL/Ubuntu
│   ├── modules/               # Shared Nix modules
│   └── programs/              # Program-specific configurations
│       ├── vim/               #   Neovim (Nixvim) + Vim
│       ├── git/               #   Git
│       ├── zsh/               #   Zsh
│       ├── coding-agents/     #   AI coding agents
│       └── ...                #   30+ more programs
└── .agents/                   # AI agent configurations
```

## Flake Inputs

| Input | Description |
| --- | --- |
| [nixpkgs](https://github.com/NixOS/nixpkgs) | Nix packages (unstable) |
| [nix-darwin](https://github.com/nix-darwin/nix-darwin) | macOS system configuration |
| [home-manager](https://github.com/nix-community/home-manager) | User environment management |
| [nixvim](https://github.com/nix-community/nixvim) | Neovim configuration in Nix |
| [treefmt-nix](https://github.com/numtide/treefmt-nix) | Multi-language formatting |
| [nix-index-database](https://github.com/nix-community/nix-index-database) | Pre-built nix-index database |

## License

This repository is for personal use. Feel free to reference or adapt any configuration for your own setup.
