-- ARCHIVED:
-- https://github.com/jose-elias-alvarez/null-ls.nvim
--
-- Current:
-- https://github.com/nvimtools/none-ls.nvim
local status, null_ls = pcall(require, 'null-ls')
local status2, mason_null_ls = pcall(require, 'mason-null-ls')
if (not status) then return end
if (not status2) then return end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

local sources = {
  -- completion.spell,
  diagnostics.eslint,
  formatting.prettier,
}

mason_null_ls.setup {
  ensure_installed = {
    'prettier'
  },
  automatic_installation = true
}

null_ls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end
  end,
  debug = true,
}

