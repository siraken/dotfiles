-- https://github.com/rcarriga/nvim-notify
local status, notify = pcall(require, 'notify')
if (not status) then return end

notify.setup {
  nvim_open_win = {
    message = {
      width = 120,
      height = 30
    },
  }
}

-- Suppress warning
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
vim.notify = function(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  end

  notify(msg, ...)
end
