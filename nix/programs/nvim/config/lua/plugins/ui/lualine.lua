return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        { "filename", path = 1, color = { fg = "#7aa2f7" } },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        { "location", padding = { left = 1, right = 1 } },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "neo-tree", "lazy", "trouble", "fzf" },
  },
}
