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
    'junegunn/fzf.vim',
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
    'neovim/nvim-lspconfig',
    'glepnir/lspsaga.nvim',
    'nvim-lua/completion-nvim',
    'github/copilot.vim',
    'EdenEast/nightfox.nvim',
    'norcalli/nvim-colorizer.lua',
    'overcache/NeoSolarized',
    'rcarriga/nvim-notify',
    'folke/trouble.nvim',
    'nvim-lua/plenary.nvim',
    'akinsho/flutter-tools.nvim',
    'folke/todo-comments.nvim',
    'shaunsingh/nord.nvim',
    'rebelot/kanagawa.nvim',
    'fatih/vim-go'
    -- 'itchyny/lightline.vim',
    -- 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
    -- Homebrew
    -- 'SiraKen/html-parser.vim',
  }
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use { 'junegunn/fzf', cmd = '-> fzf#install()'}
end)
