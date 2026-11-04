-- Load Neo-tree when Neovim starts on a directory (`nvim .`); it is otherwise
-- lazy-loaded on :Neotree and netrw would take the directory buffer.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("neotree_start_directory", { clear = true }),
  desc = "Start Neo-tree with directory",
  once = true,
  callback = function()
    if package.loaded["neo-tree"] then
      return
    end
    local stats = vim.uv.fs_stat(vim.fn.argv(0))
    if stats and stats.type == "directory" then
      require("lz.n").trigger_load("neo-tree.nvim")
    end
  end,
})
