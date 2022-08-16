local keymap = vim.keymap
local fn = vim.fn

-- Not to yank with 'x'
keymap.set('n', 'x', '"_x')

-- Increment / decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')
