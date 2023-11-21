local keymap = vim.keymap

-- Not to yank with 'x'
keymap.set('n', 'x', '"_x')

-- Increment / decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Split window
keymap.set('n', 'ss', ':split<CR><C-W>w')
keymap.set('n', 'sv', ':vsplit<CR><C-w>w')

-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Close buffer
keymap.set('n', '<C-w>q', ':bd<CR>')

-- Swap ; and :
keymap.set('n', ';', ':')
-- keymap.set('n', ':', ';')

-- Use Shift + U as redo
keymap.set('n', 'U', '<C-r>')

-- Reselect visual block after indents
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- Use Tab, Shift + Tab
keymap.set('i', '<S-Tab>', '<C-d>')
keymap.set('v', '<Tab>', '>>')
keymap.set('v', '<S-Tab>', '<<')

-- Stay visual mode after formatting
keymap.set('v', '=', '=gv')
