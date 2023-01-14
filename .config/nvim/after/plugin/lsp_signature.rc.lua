-- https://github.com/ray-x/lsp_signature.nvim
local status, lsp_signature = pcall(require, 'lsp_signature')
if (not status) then return end

local cfg = {
  debug = false,
  verbose = false,
  floating_window = true,
  close_timeout = 2000,
  fix_pos = false,
  hint_enable = false,
  handler_opts = {
    border = "rounded"
  },
  always_trigger = false,
  transparency = 50
}

lsp_signature.setup(cfg)
