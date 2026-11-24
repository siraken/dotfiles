-- Load Neo-tree when entering a directory buffer (`nvim .` or `:e dir/`).
-- Neo-tree is lazy-loaded on :Neotree and netrw is disabled, so this
-- bootstraps Neo-tree on the first directory buffer and then removes itself
-- once Neo-tree's own BufEnter hijack handler is active.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("neotree_start_directory", { clear = true }),
  desc = "Start Neo-tree with directory",
  callback = function(ev)
    if package.loaded["neo-tree"] then
      return true
    end
    local path = vim.api.nvim_buf_get_name(ev.buf)
    if path == "" then
      return
    end
    local stats = vim.uv.fs_stat(path)
    if stats and stats.type == "directory" then
      require("lz.n").trigger_load("neo-tree.nvim")
      require("neo-tree.setup.netrw").hijack()
      return true
    end
  end,
})
