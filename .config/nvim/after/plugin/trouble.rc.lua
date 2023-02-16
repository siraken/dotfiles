local status, trouble = pcall(require, 'trouble')
if (not status) then return end

trouble.setup {}

vim.keymap.set('n', 'td', '<cmd>lua require("trouble").toggle()<cr>')

