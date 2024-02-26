return {
  -- https://github.com/editorconfig/editorconfig-vim
  { "editorconfig/editorconfig-vim" },
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
      }
    }
  },
  -- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = {
        'TelescopePrompt',
        'vim'
      }
    }
  },
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    lazy = true,
    config = function()
      require("Comment").setup({})
    end,
  },
  -- https://github.com/thinca/vim-quickrun
  {
    "thinca/vim-quickrun",
    lazy = true,
  },
  -- https://github.com/Olical/conjure
  { "Olical/conjure",               lazy = false, ft = { "clojure" } },
  -- https://github.com/tpope/vim-dispatch
  { "tpope/vim-dispatch" },
  -- https://github.com/julienvincent/nvim-paredit
  {
    "julienvincent/nvim-paredit",
    config = function()
      require("nvim-paredit").setup()
    end,
  },
  -- https://github.com/pwntester/octo.nvim
  {
    "pwntester/octo.nvim",
    lazy = true,
    -- octo.setup {}
  }
}
