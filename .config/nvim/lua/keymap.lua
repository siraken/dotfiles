local keymap = vim.keymap
local fn = vim.fn

-- Input command with ; instead of :
-- keymap.set('n', ';', ':')

-- Not to yank with 'x'
keymap.set('n', 'x', '"_x')

-- Increment / decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Enter commands with ;
keymap.set('n', ';', ':')

-- Force quit
keymap.set("n", "<Space>q", ":<C-u>q!<CR>")

