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

-- Enter commands with ;
keymap.set('n', ';', ':')

-- Use Shift + U as redo
keymap.set('n', 'U', '<C-r>')

-- Force quit
keymap.set("n", "<Space>q", ":<C-u>q!<CR>")

-- Disable arrow keys
GameOver = function ()
  -- Just use '<NOP>' to disable arrow keys
  vim.cmd("q!")
end
keymap.set('n', '<Up>', GameOver)
keymap.set('n', '<Down>', GameOver)
keymap.set('n', '<Left>', GameOver)
keymap.set('n', '<Right>', GameOver)
keymap.set('i', '<Up>', GameOver)
keymap.set('i', '<Down>', GameOver)
keymap.set('i', '<Left>', GameOver)
keymap.set('i', '<Right>', GameOver)

