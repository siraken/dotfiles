vim.diagnostic.config({
  -- Nerd Font icons as escapes: private-use glyphs written literally have
  -- been silently dropped by editors before, leaving blank signs.
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{f057} ", -- nf-fa-times_circle
      [vim.diagnostic.severity.WARN] = "\u{f071} ", -- nf-fa-warning
      [vim.diagnostic.severity.INFO] = "\u{f05a} ", -- nf-fa-info_circle
      [vim.diagnostic.severity.HINT] = "\u{f0eb} ", -- nf-fa-lightbulb_o
    },
  },
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
})
