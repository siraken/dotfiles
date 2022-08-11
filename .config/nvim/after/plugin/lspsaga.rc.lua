-- local status, saga = pcall(require, 'lspsaga')
-- if (not status) then return end

-- local keymap = vim.keymap

-- saga.init_lsp_saga {
--   server_filetype_map = {}
-- }

-- local opt = { noremap = true, silent = true }

-- keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opt)
-- keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opt)
-- keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opt)
-- keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opt)
-- keymap.set('i', 'gp', '<Cmd>Lspsaga preview_definition<cr>', opt)
