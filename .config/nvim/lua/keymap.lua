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

-- Not to break line when chosen completion
-- inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

-- inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
-- inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

--
--
-- ex)
-- keymap.set('i', '<C-p>', function ()
--   return vim.fn.pumvisible() == 1 and '<Up>' or '<C-p>'
-- end, { expr = true })
--
--

-- Not to yank with 'x'
keymap.set('n', 'x', '"_x')

-- Increment / decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word
keymap.set('n', 'dw', 'vb"_d')
