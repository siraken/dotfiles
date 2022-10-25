autocmd!
set fileencodings=utf-8,sjis,euc-jp,latin
scriptencoding utf-8

set nocompatible
set langmenu=en_US
set number
set title
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set background=dark
set cmdheight=1
set ruler
set cursorline
set nobackup
set hlsearch
set ignorecase
set showcmd
set encoding=utf-8
set nowrap
set backspace=start,eol,indent
set lazyredraw
set completeopt=menuone,noinsert
set scrolloff=10
set formatoptions+=r

filetype plugin indent on
syntax enable
colorscheme habamax

" TypeScript React
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown / mdx
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Fish
au BufNewFile,BufRead *.fish set filetype=fish
" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
" yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

if exists("&termguicolors") && exists("&winblend")
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
endif

let $LANG = 'en_US'

