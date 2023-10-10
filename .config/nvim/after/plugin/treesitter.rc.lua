-- https://github.com/nvim-treesitter/nvim-treesitter
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  ensure_installed = {
    'markdown',
    'markdown_inline',
    'regex',
    'vim',
    'lua',
    'bash',
  },
  sync_install = true,
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
