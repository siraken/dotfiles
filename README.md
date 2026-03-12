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
sudo nix run nix-darwin#darwin-rebuild -- switch --flake .#THE_NAME --impure
```

After the installation, you may need to restart your terminal. The `darwin-*` commands are available in your shell.

4. Run `darwin-rebuild` or `home-manager`

To build:

```bash
# nix-darwin
sudo darwin-rebuild build --flake .#THE_NAME --impure

# home-manager
home-manager -- build --flake .#THE_NAME --impure
```

To switch:

```bash
# nix-darwin
sudo darwin-rebuild switch --flake .#THE_NAME --impure

# home-manager
home-manager -- switch --flake .#THE_NAME --impure
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

## Configuration

All program configurations are managed as Nix modules under `nix/programs/`.

### Editors

| Program | Module Path | Notes |
| --- | --- | --- |
| Neovim | `nix/programs/vim/` | Configured via [Nixvim](https://github.com/nix-community/nixvim) |
| Vim | `nix/programs/vim/` | Shares module with Neovim |
| Emacs | `nix/programs/emacs/` | |
| Helix | `nix/programs/helix/` | |
| Neovide | `nix/programs/neovide/` | Neovim GUI frontend |
| VS Code | `nix/programs/vscode/` | |
| IntelliJ IDEA | `nix/programs/idea/` | |

### Shells

| Program | Module Path |
| --- | --- |
| Bash | `nix/programs/bash/` |
| Zsh | `nix/programs/zsh/` |
| Fish | `nix/programs/fish/` |

### Terminals

| Program | Module Path |
| --- | --- |
| Kitty | `nix/programs/kitty/` |
| WezTerm | `nix/programs/wezterm/` |
| Ghostty | `nix/programs/ghostty/` |

### Dev Tools

| Program | Module Path | Notes |
| --- | --- | --- |
| Git | `nix/programs/git/` | |
| Tmux | `nix/programs/tmux/` | |
| Zellij | `nix/programs/zellij/` | |
| Yazi | `nix/programs/yazi/` | File manager |
| Direnv | `nix/programs/direnv/` | |
| Starship | `nix/programs/starship/` | Prompt |
| Mise | `nix/programs/mise/` | Runtime version manager |
| fzf | `nix/programs/fzf/` | |
| Zoxide | `nix/programs/zoxide/` | |
| bat | `nix/programs/bat/` | |
| Difftastic | `nix/programs/difftastic/` | Structural diff |
| bottom | `nix/programs/bottom/` | System monitor |
| Atuin | `nix/programs/atuin/` | Shell history |
| GitUI | `nix/programs/gitui/` | |
| gh-dash | `nix/programs/gh-dash/` | GitHub dashboard |
| Lazydocker | `nix/programs/lazydocker/` | |
| fastfetch | `nix/programs/fastfetch/` | |

### AI Agents

| Program | Module Path |
| --- | --- |
| Claude, Gemini, Codex, OpenCode | `nix/programs/coding-agents/` |
