-- https://github.com/pwntester/octo.nvim
local status, octo = pcall(require, 'octo')
if (not status) then return end

octo.setup {}
