-- ARCHIVED:
-- https://github.com/jose-elias-alvarez/null-ls.nvim
--
-- Current:
-- https://github.com/nvimtools/none-ls.nvim
local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local cmp = null_ls.builtins.completion
local dia = null_ls.builtins.diagnostics
local fmt = null_ls.builtins.formatting

local sources = {
  cmp.spell,
  dia.eslint,
  fmt.prettier,
  fmt.prettierd,
}

null_ls.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
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
