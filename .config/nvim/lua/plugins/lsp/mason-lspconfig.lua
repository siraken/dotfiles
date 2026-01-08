return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
  opts = {
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "gopls",
      "pyright",
      "rust_analyzer",
      "ruby_lsp",
      "jsonls",
      "yamlls",
      "html",
      "cssls",
      "tailwindcss",
      "dockerls",
      "nil_ls",
    },
    automatic_installation = true,
    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
            },
          },
        })
      end,
    },
  },
}
