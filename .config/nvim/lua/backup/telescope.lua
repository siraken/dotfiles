-- https://github.com/nvim-telescope/telescope.nvim
return {
  -- "nvim-telescope/telescope.nvim",
  -- dependencies = { { "nvim-lua/plenary.nvim" } },
}
-- return {
--   "nvim-telescope/telescope-frecency.nvim",
--   config = function()
--     require("telescope").load_extension("frecency")
--   end,
-- }

-- telescope.setup {
--   defaults = {
--     mappings = {
--       i = {
--       }
--     },
--     -- This is slow:
--     -- file_ignore_patterns = {
--     --   { 'node_modules' }
--     -- }
--   },
--   pickers = {
--   },
--   extensions = {
--   }
-- }

-- Keymap
-- local keymap = vim.keymap
-- local builtin = require('telescope.builtin')
-- if not vim.g.vscode then
--   keymap.set('n', 'ff', builtin.find_files, {})
--   keymap.set('n', 'fg', builtin.live_grep, {})
-- else
--   -- * VSCodeNotify() to call VSCode command
--   keymap.set('n', 'ff', "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
-- end
