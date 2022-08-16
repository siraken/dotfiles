local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local api = vim.api
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    api.nvim_command [[augroup Format]]
    api.nvim_command [[autocmd! * <buffer>]]
    api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    api.nvim_command [[augroup END]]
  end

  -- ↓ Previous config
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- local opts = { noremap = true, silent = true }

  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- require 'completion'.on_attach(client, bufnr)
end

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = {
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  cmd = { 'typescript-language-server', '--stdio' }
}

-- nvim_lsp.sumneko_lua.setup {
--   on_attach = on_attach,
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = {'vim'}
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true)
--       }
--     }
--   }
-- }
