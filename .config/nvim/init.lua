require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

local has = vim.fn.has
local opt = vim.opt

if has("macunix") == 1 then
  opt.clipboard:append { 'unnamedplus' }
end

if has("win32") == 1 then
  opt.clipboard:append { 'unnamed', 'unnamedplus' }
end

-- Neovide GUI settings
if vim.g.neovide then
  require("config.neovide")
end

-- if vim.g.exists(':GuiFont') then
--   GuiFont! Hack Nerd Font Mono:h16
-- end

-- if vim.g.exists(':GuiWindowOpacity') then
--   GuiWindowOpacity .85
-- end
