-- https://github.com/folke/tokyonight.nvim
return {
  "folke/tokyonight.nvim",
  lazy = false,
  branch = "main",
  opts = {
    style = "night",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    day_brightness = 0.3,
  },
}
