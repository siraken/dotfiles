local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

saga.init_lsp_saga {
}

keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
keymap.set('n', 'gn', '<Cmd>Lspsaga rename<cr>', opts)
keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<cr>', opts)
keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
