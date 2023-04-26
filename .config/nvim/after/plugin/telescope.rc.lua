require('telescope').setup {
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
  vim.keymap.set('n', 'ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
else
  -- * VSCodeNotify() to call VSCode command
  keymap.set('n', 'ff', "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
end
