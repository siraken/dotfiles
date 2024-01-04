local plugins = {
  --
  -- Language support
  --
  { "tomlion/vim-solidity" },
  { "ziglang/zig.vim" },
  { "editorconfig/editorconfig-vim" },
  { "OmniSharp/omnisharp-vim" },
  { "udalov/kotlin-vim" },
  { "akinsho/flutter-tools.nvim" },
  { "wuelnerdotexe/vim-astro" },
  -- FIXME: rtp can be accomplished.
  -- Read: https://github.com/folke/lazy.nvim#-migration-guide
  { "vlime/vlime", rtp = "vim" },
  { "vim-scripts/paredit.vim" },
  { "Olical/conjure", ft = { "clojure" } },
  { "tpope/vim-dispatch" },
  { "clojure-vim/vim-jack-in" },
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
  { "itchyny/calendar.vim" },
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
