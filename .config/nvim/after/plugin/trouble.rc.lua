require("trouble").setup {}

vim.keymap.set('n', 'td', '<cmd>lua require("trouble").toggle()<cr>')

