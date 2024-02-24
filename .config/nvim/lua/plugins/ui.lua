return {
  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    enabled = false,
    opts = { mode = "cursor", max_lines = 3 },
  },
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    -- vim.keymap.set('n', 'td', '<Cmd>TroubleToggle<CR>')
  },
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    -- which_key.setup {}
  },
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    -- gitsigns.setup {}
  },
  -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  -- https://github.com/norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- https://github.com/itchyny/calendar.vim
  { "itchyny/calendar.vim" },
}
