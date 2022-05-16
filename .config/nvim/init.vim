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

highlight CurrLine ctermbg=magenta cterm=bold ctermfg=white

syntax enable

colorscheme monokai

runtime ./plug.vim

lua << EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		disable = {}
	},
	indent = {
		enable = true,
		strategy = 'tab',
		indent_size = 2
	},
}
EOF

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

let g:airline#extensions#tabline#enabled = 1

:command Tr NERDTree
