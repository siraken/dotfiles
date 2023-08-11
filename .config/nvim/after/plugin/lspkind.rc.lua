-- https://github.com/onsails/lspkind.nvim
local status, lspkind = pcall(require, 'lspkind')
if (not status) then return end

lspkind.init({
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = 'symbol_text',
  preset = 'codicons',
})
