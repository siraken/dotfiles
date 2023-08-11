-- https://github.com/nvim-telescope/telescope.nvim
local status, telescope = pcall(require, 'telescope')
if (not status) then return end

telescope.setup {
  defaults = {
    mappings = {
      i = {
      }
    },
    -- This is slow:
    -- file_ignore_patterns = {
    --   { 'node_modules' }
    -- }
  },
  pickers = {
  },
  extensions = {
  }
}

-- Keymap
local keymap = vim.keymap
if not vim.g.vscode then
  keymap.set('n', 'ff', '<Cmd>lua require("telescope.builtin").find_files()<CR>')
else
  -- * VSCodeNotify() to call VSCode command
  keymap.set('n', 'ff', "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
end
