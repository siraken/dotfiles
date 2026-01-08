return {
  "folke/tokyonight.nvim",
  lazy = false,
  branch = "main",
  opts = {
    transparent = true,
    terminal_colors = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    day_brightness = 0.3,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
