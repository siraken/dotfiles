local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

saga.init_lsp_saga {
  server_filetype_map = {}
}

keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)
keymap.set('i', 'gp', '<Cmd>Lspsaga preview_definition<cr>', opts)
