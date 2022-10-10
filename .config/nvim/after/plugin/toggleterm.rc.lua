local status, term = pcall(require, 'toggleterm')
if (not status) then return end

term.setup {}
