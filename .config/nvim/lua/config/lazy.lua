-- Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_repo = "https://github.com/folke/lazy.nvim.git"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazy_repo,
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
  spec = {
    -- ** plugins **
    { import = "plugins.avante" },
    -- { import = "plugins.coding" },
    { import = "plugins.colorscheme" },
    -- { import = "plugins.completion" },
    { import = "plugins.core" },
    -- { import = "plugins.editor" },
    -- { import = "plugins.git" },
    -- { import = "plugins.lang" },
    -- { import = "plugins.lsp" },
    -- { import = "plugins.misc" },
    -- { import = "plugins.treesitter" },
    -- { import = "plugins.ui" },

    -- ** language-specific plugins **
    -- { import = "plugins.lang.clojure.lua" },
    -- { import = "plugins.lang.dotnet.lua" },
    -- { import = "plugins.lang.java.lua" },
    -- { import = "plugins.lang.lisp.lua" },
    -- { import = "plugins.lang.markdown.lua" },
    -- { import = "plugins.lang.python.lua" },
    -- { import = "plugins.lang.ruby.lua" },
    -- { import = "plugins.lang.rust.lua" },
    { import = "plugins.lang.typescript.lua" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
