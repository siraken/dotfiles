# Neovim Configuration

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as plugin manager.

## Requirements

- Neovim >= 0.10.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- Node.js (for some LSP servers and tools)
- ripgrep (for live grep)
- fzf (for fuzzy finding)

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone dotfiles and symlink
git clone https://github.com/siraken/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/.config/nvim ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

After first launch, run `:Lazy sync` to ensure all plugins are installed.

## Directory Structure

```
nvim/
├── init.lua                 # Entry point
├── lazy-lock.json           # Plugin version lock file
├── lua/
│   ├── config/
│   │   ├── autocmds.lua     # Autocommands
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── macos.lua        # macOS-specific settings
│   │   ├── neovide.lua      # Neovide GUI settings
│   │   ├── options.lua      # Editor options
│   │   └── windows.lua      # Windows-specific settings
│   └── plugins/
│       ├── ai.lua           # AI assistants (Claude Code, Copilot)
│       ├── coding.lua       # Coding tools (formatting, pairs, comments)
│       ├── colorscheme.lua  # Color schemes
│       ├── completion.lua   # Completion engine
│       ├── core.lua         # Core dependencies
│       ├── editor.lua       # Editor features (file tree, search, motion)
│       ├── git.lua          # Git integration
│       ├── lsp.lua          # Language Server Protocol
│       ├── misc.lua         # Miscellaneous plugins
│       ├── treesitter.lua   # Syntax highlighting
│       ├── ui.lua           # UI enhancements
│       └── lang/            # Language-specific plugins
│           ├── clojure.lua
│           ├── dotnet.lua
│           ├── java.lua
│           ├── lisp.lua
│           ├── markdown.lua
│           ├── python.lua
│           ├── rust.lua
│           ├── typescript.lua
│           └── web.lua
```

## Plugin Overview

### Core

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Utility collection |
| [mini.icons](https://github.com/echasnovski/mini.icons) | Icons |

### Editor

| Plugin | Description |
|--------|-------------|
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder |
| [flash.nvim](https://github.com/folke/flash.nvim) | Navigation/motion |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Session management |

### UI

| Plugin | Description |
|--------|-------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Color scheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI for messages/cmdline |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |

### Coding

| Plugin | Description |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linter |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto pairs |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim) | Yank history |

### Git

| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs |
| [octo.nvim](https://github.com/pwntester/octo.nvim) | GitHub integration |

### AI

| Plugin | Description |
|--------|-------------|
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |

### Language Support

| Language | Plugins |
|----------|---------|
| Rust | rustaceanvim, crates.nvim |
| Python | venv-selector.nvim |
| TypeScript/JavaScript | Built-in LSP, tailwindcss-colorizer |
| Go | Built-in LSP |
| Ruby | Built-in LSP |
| Java | nvim-jdtls |
| C#/.NET | omnisharp-extended-lsp |
| Clojure | conjure, vim-jack-in |
| Common Lisp | vlime |
| Markdown | markdown-preview, render-markdown |

## Key Mappings

Leader key: `<Space>`

### General

| Key | Description |
|-----|-------------|
| `<leader>l` | Open Lazy (plugin manager) |
| `<leader>qq` | Quit all |
| `<Esc>` | Clear search highlight |
| `U` | Redo |

### File/Buffer

| Key | Description |
|-----|-------------|
| `<leader>e` | Toggle file explorer |
| `<leader><space>` | Find files |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Buffers |
| `<leader>/` | Live grep |
| `<leader>sg` | Live grep |
| `<leader>fn` | New file |
| `<leader>bd` | Delete buffer |
| `[b` / `]b` | Previous/Next buffer |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename |
| `<leader>cf` | Format |
| `<leader>cd` | Line diagnostics |
| `[d` / `]d` | Previous/Next diagnostic |

### Search & Replace

| Key | Description |
|-----|-------------|
| `<leader>sr` | Search and replace (grug-far) |
| `<leader>ss` | Document symbols |
| `<leader>sS` | Workspace symbols |
| `<leader>sw` | Grep word under cursor |

### Git

| Key | Description |
|-----|-------------|
| `]h` / `[h` | Next/Previous hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |

### Motion (Flash)

| Key | Description |
|-----|-------------|
| `s` | Flash jump |
| `S` | Flash treesitter |

### Windows

| Key | Description |
|-----|-------------|
| `ss` | Split horizontal |
| `sv` | Split vertical |
| `sh/sj/sk/sl` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize window |

### AI (Claude Code)

| Key | Description |
|-----|-------------|
| `<leader>ac` | Toggle Claude Code |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume conversation |
| `<leader>as` | Send to Claude (visual) |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

### Session

| Key | Description |
|-----|-------------|
| `<leader>qs` | Restore session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save session |

## LSP Servers

Automatically installed via Mason:

- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `gopls` - Go
- `pyright` - Python
- `rust_analyzer` - Rust
- `ruby_lsp` - Ruby
- `jsonls` - JSON
- `yamlls` - YAML
- `html` - HTML
- `cssls` - CSS
- `tailwindcss` - Tailwind CSS
- `dockerls` - Docker
- `nil_ls` - Nix

## Formatters

Configured in `conform.nvim`:

| Language | Formatter |
|----------|-----------|
| Lua | stylua |
| JavaScript/TypeScript | prettierd, prettier |
| JSON/YAML/HTML/CSS/Markdown | prettierd, prettier |
| Shell | shfmt |

## Color Scheme

Using [TokyoNight](https://github.com/folke/tokyonight.nvim) with transparent background.

## Customization

### Adding a new plugin

Create or edit a file in `lua/plugins/`:

```lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy", -- lazy loading
    opts = {
      -- plugin options
    },
  },
}
```

### Adding a new LSP server

Edit `lua/plugins/lsp.lua` and add to `ensure_installed`:

```lua
opts = {
  ensure_installed = {
    -- existing servers...
    "new_server",
  },
}
```

### Adding a new formatter

Edit `lua/plugins/coding.lua` and add to `formatters_by_ft`:

```lua
opts = {
  formatters_by_ft = {
    -- existing formatters...
    newlang = { "formatter_name" },
  },
}
```
