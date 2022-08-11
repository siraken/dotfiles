local keymap = vim.keymap

-- coc.nvim
-- Navigate completion by <Tab>
-- function! s:check_back_space() abort
--   let col = col('.') - 1
--   return !col || getline('.')[col - 1]  =~ '\s'
-- endfunction

-- inoremap <silent><expr> <Tab>
--       \ pumvisible() ? "\<C-n>" :
--       \ <SID>check_back_space() ? "\<Tab>" :
--       \ coc#refresh()
-- <Tab> for next, <S+Tab> for prev
-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

-- inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

-- inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
-- inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
