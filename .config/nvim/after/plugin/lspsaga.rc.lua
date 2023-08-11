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

keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
keymap.set('n', 'gr', '<Cmd>Lspsaga lsp_finder<CR>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga peek_definition<CR>', opts)
keymap.set('n', 'ga', '<Cmd>Lspsaga code_action<CR>', opts)
keymap.set('n', 'gn', '<Cmd>Lspsaga rename<CR>', opts)
keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap.set('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
