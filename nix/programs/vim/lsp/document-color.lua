-- Neovim 0.12 highlights LSP document colors by default; nvim-colorizer
-- already does that in every buffer, so cssls / tailwindcss would draw twice.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("disable_lsp_document_color", { clear = true }),
  callback = function(ev)
    vim.lsp.document_color.enable(false, { bufnr = ev.buf })
  end,
})
