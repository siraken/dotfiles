-- Treesitter configuration
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  -- Treesitter textobjects (disabled: incompatible with nvim-treesitter v1.0+)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
  },
  -- Treesitter context (disabled by default)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    enabled = false,
    opts = { mode = "cursor", max_lines = 3 },
  },
  -- Auto close/rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  -- Better comments based on treesitter
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
