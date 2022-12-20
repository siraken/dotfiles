local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
  -- Packer
  use { 'wbthomason/packer.nvim' }
  -- use { 'wbthomason/packer.nvim', opt = true }
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
  -- LSP-related
  use 'onsails/lspkind.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'j-hui/fidget.nvim'
  use 'dense-analysis/ale'
  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'
  use 'nvim-lua/completion-nvim'
  -- Notification
  use 'rcarriga/nvim-notify'
  -- use {
  --   'folke/noice.nvim',
  --   requires = {
  --     { 'MunifTanjim/nui.nvim' }
  --   }
  -- }
  -- Display style
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/trouble.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use { 'akinsho/bufferline.nvim', tag = "v2.*" } -- Tab
  -- Utilities
  use 'github/copilot.vim'
  use 'itchyny/calendar.vim'
  use 'prettier/vim-prettier'
  use 'pwntester/octo.nvim'
  -- Uncategorized yet
  use 'terryma/vim-multiple-cursors'
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'
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
  -- Homebrew
  -- use 'SiraKen/html-parser.vim'
end)
