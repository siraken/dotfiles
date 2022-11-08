autocmd!

scriptencoding utf-8
filetype plugin indent on
syntax enable
colorscheme habamax

set nocompatible

set number
set signcolumn=yes
set laststatus=2
set cmdheight=1
set showtabline=2

set virtualedit=block
set wildmenu
set wildignorecase

set tabstop=2
set expandtab
set shiftwidth=2
set smartindent

set hlsearch
set ignorecase
set smartcase
set incsearch

set noswapfile
set nobackup
set noundofile
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,latin

set title
set smarttab
set background=dark
set ruler
set cursorline
set showcmd
set nowrap
set backspace=start,eol,indent
set lazyredraw
set completeopt=menuone,noinsert
set scrolloff=10
set formatoptions+=r
set langmenu=en_US

nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
au BufNewFile,BufRead *.fish set filetype=fish

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

let $LANG = 'en_US'

