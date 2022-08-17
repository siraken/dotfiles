local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',
    'lambdalisue/fern.vim',
    'mattn/emmet-vim',
    'preservim/nerdtree',
    'ryanoasis/vim-devicons',
    'leafgarland/typescript-vim',
    'jwalton512/vim-blade',
    'ctrlpvim/ctrlp.vim',
    'tomlion/vim-solidity',
    'rust-lang/rust.vim',
    'terryma/vim-multiple-cursors',
    'tpope/vim-commentary',
    'tomasiser/vim-code-dark',
    'sickill/vim-monokai',
    'tomasr/molokai',
    'cocopon/iceberg.vim',
    'bfontaine/Brewfile.vim',
    'editorconfig/editorconfig-vim',
    'maxmellon/vim-jsx-pretty',
    'ziglang/zig.vim',
    'KeitaNakamura/neodark.vim',
    'isobit/vim-caddyfile',
    'OmniSharp/omnisharp-vim',
    'udalov/kotlin-vim',
    'itchyny/calendar.vim',
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    -- 'hrsh7th/cmp-path',
    'glepnir/lspsaga.nvim',
    'nvim-lua/completion-nvim',
    'github/copilot.vim',
    'EdenEast/nightfox.nvim',
    'norcalli/nvim-colorizer.lua',
    'overcache/NeoSolarized',
    'rcarriga/nvim-notify',
    'folke/trouble.nvim',
    'akinsho/flutter-tools.nvim',
    'folke/todo-comments.nvim',
    'shaunsingh/nord.nvim',
    'rebelot/kanagawa.nvim',
    'fatih/vim-go',
    'lewis6991/gitsigns.nvim',
    -- 'itchyny/lightline.vim',
    -- Homebrew
    -- 'SiraKen/html-parser.vim',
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use { 'junegunn/fzf' }
  -- use { 'neoclide/coc.nvim', branch = 'release' }
end)
