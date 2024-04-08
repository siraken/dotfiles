require("config.lazy")

local has = vim.fn.has

local is_mac = has("macunix")
local is_win = has("win32")
local is_wsl = has("wsl")

if is_mac then
  require("config.macos")
end

if is_win then
  require("config.windows")
end

require("config.neovide")
