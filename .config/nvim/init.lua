require('siraken.plugins')
require('siraken.config')
require('siraken.keymap')

local has = vim.fn.has

local is_mac = has 'macunix'
local is_win = has 'win32'
local is_wsl = has 'wsl'

if is_mac then
  require('siraken.macos')
end

if is_win then
  require('siraken.windows')
end
