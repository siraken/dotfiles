autocmd!

scriptencoding utf-8
filetype plugin indent on
syntax enable
colorscheme industry

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
set fileencodings=euc-jp,sjis,latin,utf-8
set fileformats=unix,dos,mac

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

" Increment / decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Select all
nnoremap <C-a> gg<S-v>G

" Spit window
nnoremap ss :split<CR><C-W>w
nnoremap sv :vsplit<CR><C-w>w

" Move window
nnoremap <Space> <C-w>w
noremap sh <C-w>h
noremap sk <C-w>k
noremap sj <C-w>j
noremap sl <C-w>l

" Resize window
nnoremap <C-w><left> <C-w><
nnoremap <C-w><right> <C-w>>
nnoremap <C-w><up> <C-w>+
nnoremap <C-w><down> <C-w>-

" Close buffer
nnoremap <C-w>q :bd<CR>

" Use Shift + U as redo
nnoremap U <C-r>

" Reselect visual block after indents
xnoremap < <gv
xnoremap > >gv

" Use Tab, Shift + Tab
inoremap <S-Tab> <C-d>
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" Auto close brackets
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>

" Stay visual mode after formatting
xnoremap = =gv

let $LANG = 'en_US'
