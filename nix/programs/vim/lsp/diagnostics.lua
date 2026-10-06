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
  -- Show the diagnostic in a float after the default ]d / [d jumps, as the
  -- deprecated goto_next/goto_prev used to (`float` is deprecated in 0.12).
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})
