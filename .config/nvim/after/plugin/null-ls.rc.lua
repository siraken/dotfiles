-- https://github.com/jose-elias-alvarez/null-ls.nvim
local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local d = null_ls.builtins.diagnostics
local f = null_ls.builtins.formatting

local sources = {
  d.eslint.with {
    prefer_local = 'node_modules/.bin'
  },
  f.prettier.with {
    condition = function(utils)
      return utils.has_file { '.prettierrc' }
    end,
  },
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
