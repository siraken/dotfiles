return {
  -- NeoVim LSP Config
  -- https://github.com/neovim/nvim-lspconfig
  -- Mason Config
  -- https://github.com/williamboman/mason.nvim
  -- Mason LSP Config
  -- https://github.com/williamboman/mason-lspconfig.nvim
  -- Neovim LSP
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
  },
  -- https://github.com/sheerun/vim-polyglot
  {
    "sheerun/vim-polyglot",
    -- polyglot.setup {}
  },
}
