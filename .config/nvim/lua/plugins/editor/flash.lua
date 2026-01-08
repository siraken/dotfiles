return {
  "folke/flash.nvim",
  event = "BufReadPost",
  opts = {
    modes = {
      char = { enabled = false },
      search = { enabled = false },
      treesitter = { enabled = false },
    },
  },
  keys = {
    {
      "<CR>",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          label = { before = true, after = false },
        })
      end,
      desc = "Flash",
    },
  },
}
