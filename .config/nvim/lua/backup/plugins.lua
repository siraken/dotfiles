local plugins = {
  --
  -- Language support
  --
  { "udalov/kotlin-vim" },
  { "akinsho/flutter-tools.nvim" },
  { "vim-scripts/paredit.vim" },
  { "radenling/vim-dispatch-neovim" },
  { "roobert/tailwindcss-colorizer-cmp.nvim" },
  { "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
  --
  -- LSP-related
  --
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  --
  -- Completion
  --
  { "L3MON4D3/LuaSnip" },
  ---
  --- Debugging
  ---
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
  },
  { "theHamsta/nvim-dap-virtual-text" },
  --
  -- UI for messages, cmdline, popup, etc.
  --
  { "RRethy/vim-illuminate" },
  --
  -- Display style
  --
  { "mhinz/vim-startify" }, -- Startup screen
  { "norcalli/nvim-colorizer.lua" },
  --
  -- Utilities
  --
  { "dhruvasagar/vim-table-mode" },
  { "dstein64/vim-startuptime" },
  { "guns/vim-sexp" },
  --
  -- Uncategorized yet
  --
  { "mg979/vim-visual-multi" },
  { "folke/neodev.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  --
  -- Homebrew
  --
  -- { 'siraken/html-parser.vim' }
}

require("lazy").setup(plugins, {})
