local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'
  -- Neovim LSP
  use 'neovim/nvim-lspconfig'
  -- Mason: LSP client for Neovim
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  -- Colorschemes
  use 'tomasiser/vim-code-dark'
  use 'sickill/vim-monokai'
  use 'cocopon/iceberg.vim'
  use 'KeitaNakamura/neodark.vim'
  use 'EdenEast/nightfox.nvim'
  use 'overcache/NeoSolarized'
  use 'shaunsingh/nord.nvim'
  use 'rebelot/kanagawa.nvim'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  -- Language support
  use 'bfontaine/Brewfile.vim'
  use 'mattn/emmet-vim'
  use 'leafgarland/typescript-vim'
  use 'tomlion/vim-solidity'
  use 'rust-lang/rust.vim'
  use 'ziglang/zig.vim'
  use 'editorconfig/editorconfig-vim'
  use 'maxmellon/vim-jsx-pretty'
  use 'isobit/vim-caddyfile'
  use 'OmniSharp/omnisharp-vim'
  use 'udalov/kotlin-vim'
  use 'akinsho/flutter-tools.nvim'
  use 'fatih/vim-go'
  use 'wuelnerdotexe/vim-astro'
  -- Other plugins
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'preservim/nerdtree'
  use 'terryma/vim-multiple-cursors'
  use 'numToStr/Comment.nvim'
  use 'itchyny/calendar.vim'
  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-path'
  use 'glepnir/lspsaga.nvim'
  use 'nvim-lua/completion-nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'rcarriga/nvim-notify'
  use 'folke/trouble.nvim'
  use 'folke/todo-comments.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use 'github/copilot.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  -- Homebrew
  -- use 'SiraKen/html-parser.vim'
end)
