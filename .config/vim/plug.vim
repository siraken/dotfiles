call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/fern.vim'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jwalton512/vim-blade'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomlion/vim-solidity'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'
Plug 'bfontaine/Brewfile.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ziglang/zig.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'isobit/vim-caddyfile'
Plug 'OmniSharp/omnisharp-vim'
Plug 'udalov/kotlin-vim'
" Plug 'itchyny/lightline.vim'
Plug 'itchyny/calendar.vim'

" Homebrew
" Plug 'SiraKen/html-parser.vim'

if has("nvim")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lua/completion-nvim'
  Plug 'github/copilot.vim'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'overcache/NeoSolarized'
  Plug 'rcarriga/nvim-notify'
  Plug 'folke/trouble.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'akinsho/flutter-tools.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'shaunsingh/nord.nvim'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'rebelot/kanagawa.nvim'
endif

call plug#end()
