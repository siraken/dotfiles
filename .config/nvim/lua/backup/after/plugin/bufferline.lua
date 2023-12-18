-- https://github.com/akinsho/bufferline.nvim
local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {}

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
