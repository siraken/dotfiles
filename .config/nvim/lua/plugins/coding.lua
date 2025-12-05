-- Coding assistance plugins (formatting, pairing, comments, structural editing)
return {
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
      },
    },
  },
  -- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = {
        "TelescopePrompt",
        "vim",
      },
    },
  },
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    lazy = true,
    config = function()
      require("Comment").setup({})
    end,
  },
  -- https://github.com/julienvincent/nvim-paredit
  {
    "julienvincent/nvim-paredit",
    config = function()
      require("nvim-paredit").setup()
    end,
  },
}
