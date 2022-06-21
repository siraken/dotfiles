autocmd!
scriptencoding utf-8

set nocompatible
set number
set title
set tabstop=2
set shiftwidth=2
set autoindent
set background=dark
set cmdheight=1
set ruler
set cursorline
set nobackup
set hlsearch
set ignorecase
set showcmd
set expandtab
set encoding=utf-8
set nowrap
set backspace=start,eol,indent
set lazyredraw
set completeopt=menuone,noinsert

highlight CurrLine ctermbg=magenta cterm=bold ctermfg=white

syntax enable
filetype plugin indent on

colorscheme monokai

runtime ./plug.vim

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

let g:airline#extensions#tabline#enabled = 1

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
\]

:command Tr NERDTree
