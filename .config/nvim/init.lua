-- Load core configuration
require("config.options")
-- require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- Platform-specific settings
local has = vim.fn.has

if has("macunix") == 1 then
  require("config.macos")
end

if has("win32") == 1 then
  require("config.windows")
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
