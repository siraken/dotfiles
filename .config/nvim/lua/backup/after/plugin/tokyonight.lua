-- https://github.com/folke/tokyonight.nvim
local status, tokyonight = pcall(require, 'tokyonight')
if (not status) then return end

tokyonight.setup {
  style = 'night',
  light_style = 'day',
  transparent = false,
  terminal_colors = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  day_brightness = 0.3,
  lualine_bold = true,
}

vim.api.nvim_command [[colorscheme tokyonight]]
