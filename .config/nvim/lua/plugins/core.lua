-- Core dependencies and utilities
return {
  -- Library used by many plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  -- UI library
  { "MunifTanjim/nui.nvim", lazy = true },
  -- Icons
  { "echasnovski/mini.icons", lazy = true },
  -- Snacks utilities
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
  },
}
