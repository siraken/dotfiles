-- UI enhancement plugins
return {
  -- https://github.com/akinsho/bufferline.nvim
  {
    -- "akinsho/bufferline.nvim", version = "*"
    -- bufferline.setup {}
    --
    -- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
    -- vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
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
  -- https://github.com/norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
