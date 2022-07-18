autocmd!
set fileencodings=utf-8,sjis,euc-jp,latin
scriptencoding utf-8

set nocompatible
set langmenu=en_US
set number
set title
set tabstop=2
set shiftwidth=2
" set softtabstop=0
set expandtab
set smarttab
" set autoindent
set smartindent
" set cindent
" set shiftround
set background=dark
set cmdheight=1
set ruler
set cursorline
" set cursorcolumn
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
" set shell=zsh
filetype plugin indent on

" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

if has('nvim')
  set inccommand=split
endif

if exists("&termguicolors") && exists("&winblend")
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
endif

highlight CurrLine ctermbg=magenta cterm=bold ctermfg=white

syntax enable
filetype plugin indent on

runtime ./plug.vim

colorscheme monokai

"" coc.nvim
""" Navigate completion by <Tab>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
""" <Tab> for next, <S+Tab> for prev
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:NERDTreeWinSize = 24

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let g:rustfmt_autosave = 1

let g:go_template_autocreate = 0

let g:coc_global_extensions = [
      \'coc-go',
      \'coc-html',
      \'coc-json',
      \'coc-sh',
      \'coc-tailwindcss',
      \'coc-tsserver',
      \'coc-blade',
      \'coc-yaml',
      \'coc-java',
      \'coc-markdownlint',
      \'coc-spell-checker',
      \'coc-highlight',
      \'coc-git',
      \'coc-deno',
      \'coc-pyright',
      \'coc-vetur',
      \'coc-kotlin',
      \'coc-rls',
      \'coc-flutter',
      \'@yaegassy/coc-intelephense',
\]

let $LANG = 'en_US'

:command Tr NERDTree
