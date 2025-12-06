-- Miscellaneous plugins
return {
  -- Calendar
  { "itchyny/calendar.vim", cmd = "Calendar" },
  -- Polyglot syntax
  { "sheerun/vim-polyglot", event = { "BufReadPost", "BufNewFile" } },
}
