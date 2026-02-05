return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>p",
      function()
        require("fzf-lua").registers()
      end,
      desc = "Paste from registers",
    },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
  },
  opts = {
    highlight = { timer = 200 },
  },
}
