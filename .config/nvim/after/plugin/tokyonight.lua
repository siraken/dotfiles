-- https://github.com/folke/tokyonight.nvim
local status, tokyonight = pcall(require, 'tokyonight')
if (not status) then return end

tokyonight.setup {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
}

vim.api.nvim_command [[colorscheme tokyonight]]
