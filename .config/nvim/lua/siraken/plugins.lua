-- Plugins
--
-- Icons:
-- https://www.nerdfonts.com/cheat-sheet
local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Packer
  use { 'wbthomason/packer.nvim' }
  -- Neovim LSP
  use 'neovim/nvim-lspconfig'
  -- Mason: LSP client for Neovim
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  --
  -- Colorschemes
  --
  use 'sickill/vim-monokai'
  use 'cocopon/iceberg.vim'
  use 'KeitaNakamura/neodark.vim'
  use 'EdenEast/nightfox.nvim'
  use 'overcache/NeoSolarized'
  use 'shaunsingh/nord.nvim'
  use 'morhetz/gruvbox'
  use 'rebelot/kanagawa.nvim'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'Mofiqul/vscode.nvim'
  --
  -- Language support
  --
  use 'bfontaine/Brewfile.vim'
  use 'tomlion/vim-solidity'
  use 'ziglang/zig.vim'
  use 'editorconfig/editorconfig-vim'
  use 'isobit/vim-caddyfile'
  use 'OmniSharp/omnisharp-vim'
  use 'udalov/kotlin-vim'
  use 'akinsho/flutter-tools.nvim'
  use 'wuelnerdotexe/vim-astro'
  use { 'vlime/vlime', rtp = 'vim' }
  use 'vim-scripts/paredit.vim'
  use 'Olical/conjure'
  use 'tpope/vim-dispatch'
  use 'clojure-vim/vim-jack-in'
  use 'radenling/vim-dispatch-neovim'
  use 'roobert/tailwindcss-colorizer-cmp.nvim'
  use { 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } }
  --
  -- LSP-related
  --
  use 'onsails/lspkind.nvim' -- VSCode-like pictograms
  use 'nvimdev/lspsaga.nvim' -- LSP UIs
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'ray-x/lsp_signature.nvim'
  use { 'j-hui/fidget.nvim', tag = 'legacy' }
  --
  -- Completion
  --
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'
  use 'nvim-lua/completion-nvim'
  --
  -- Editing
  --
  use 'guns/vim-sexp'
  --
  -- Notification
  --
  use 'rcarriga/nvim-notify'
  -- use {
  --   'folke/noice.nvim',
  --   requires = {
  --     { 'MunifTanjim/nui.nvim' }
  --   }
  -- }
  --
  -- Display style
  --
  use 'mhinz/vim-startify'        -- Startup screen
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/trouble.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'
  use { 'akinsho/bufferline.nvim', tag = "*" } -- Tab
  --
  -- Utilities
  --
  use 'github/copilot.vim'
  use 'jackMort/ChatGPT.nvim'
  use 'itchyny/calendar.vim'
  use 'prettier/vim-prettier'
  use 'pwntester/octo.nvim'
  use 'dhruvasagar/vim-table-mode'
  --
  -- Uncategorized yet
  --
  use 'mg979/vim-visual-multi'
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/which-key.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  }
  use {
    'akinsho/toggleterm.nvim',
    tag = '*'
  }
  --
  -- Homebrew
  --
  -- use 'siraken/html-parser.vim'
end)
