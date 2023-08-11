-- https://github.com/jackMort/ChatGPT.nvim
local status, gpt = pcall(require, 'chatgpt')
if (not status) then return end

-- FIXME: does not work
gpt.setup {}
