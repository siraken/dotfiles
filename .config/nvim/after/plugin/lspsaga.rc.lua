local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup({
  symbol_in_winbar = {
    enable = false,
  },
  code_action_lightbulb = {
    enable = true,
  },
})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
keymap.set('n', 'gr', '<Cmd>Lspsaga lsp_finder<cr>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga peek_definition<cr>', opts)
keymap.set('n', 'ga', '<Cmd>Lspsaga code_action<cr>', opts)
keymap.set('n', 'gn', '<Cmd>Lspsaga rename<cr>', opts)
keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<cr>', opts)
keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
keymap.set('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', opts)

keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
