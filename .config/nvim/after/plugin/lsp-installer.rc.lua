local status, lsp_installer = pcall(require, 'nvim-lsp-installer')
if (not status) then return end

lsp_installer.setup({
  automatic_installation = false,
  -- Language name A to Z
  -- To check installation status, run `:LspInstallInfo`
  -- More info, see https://github.com/williamboman/nvim-lsp-installer#available-lsps
  -- ensure_installed = {
  --   "angularls",
  --   "arduino_language_server",
  --   "asm_lsp",
  --   "bashls",
  --   "ccls",
  --   "omnisharp",
  --   "cssls",
  --   "clojure_lsp",
  --   "dartls",
  --   "denols",
  --   "dockerls",
  --   "eslint",
  --   "emmet_ls",
  --   "gopls",
  --   "grammarly",
  --   "graphql",
  --   "html",
  --   "jsonls",
  --   "jdtls",
  --   "tsserver",
  --   "kotlin_language_server",
  --   "sumneko_lua",
  --   "intelephense",
  --   "perlnavigator",
  --   "powershell_es",
  --   "pylsp",
  --   "solargraph",
  --   "rust_analyzer",
  --   "sqlls",
  --   "solidity_ls",
  --   "svelte",
  --   "sourcekit",
  --   "taplo",
  --   "tailwindcss",
  --   "tflint",
  --   "volar",
  --   "lemminx",
  --   "yamlls",
  --   "zls",
  -- },
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
