-- https://github.com/nvim-tree/nvim-web-devicons
local status, devicons = pcall(require, "nvim-web-devicons")
if (not status) then return end

devicons.setup({
  override = {
    ts = {
      icon = "󰛦",
      color = "#3178C6",
      name = "Typescript"
    },
  },
  color_icons = true,
  strict = true,
})
