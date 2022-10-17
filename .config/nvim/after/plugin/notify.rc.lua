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
