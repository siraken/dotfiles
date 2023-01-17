-- https://github.com/nvim-treesitter/nvim-treesitter
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = {
      'php'
    }
  },
  indent = {
    enable = false,
    disable = {},
  },
  autotag = {
    enable = true,
  }
}
