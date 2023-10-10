-- ARCHIVED:
-- https://github.com/jose-elias-alvarez/null-ls.nvim
--
-- Current:
-- https://github.com/nvimtools/none-ls.nvim
local status, nl = pcall(require, 'null-ls')
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local c = nl.builtins.completion
local d = nl.builtins.diagnostics
local f = nl.builtins.formatting

local sources = {
  c.spell,
  d.eslint,
  f.prettier,
  f.prettierd,
}

nl.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function()
              return client.name == 'null-ls'
            end,
          })
        end,
      })
    end
  end,
  debug = false,
}
