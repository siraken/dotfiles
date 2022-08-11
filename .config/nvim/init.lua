require('config')
require('keymap')
require('plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has 'macunix'
local is_win = has 'win32'

if is_mac then
  -- print('macOS')
end

if is_win then
  print('Windows')
end
