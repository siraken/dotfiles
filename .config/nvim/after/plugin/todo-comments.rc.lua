-- https://github.com/folke/todo-comments.nvim
local status, todo = pcall(require, 'todo-comments')
if (not status) then return end

todo.setup {}
