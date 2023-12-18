-- https://github.com/sheerun/vim-polyglot
local status, polyglot = pcall(require, 'vim-polyglot')
if (not status) then return end

polyglot.setup {}
