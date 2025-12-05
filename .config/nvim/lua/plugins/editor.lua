-- Core editor plugins (file tree, editorconfig, task runners)
return {
  -- https://github.com/editorconfig/editorconfig-vim
  { "editorconfig/editorconfig-vim" },
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },
  -- https://github.com/thinca/vim-quickrun
  {
    "thinca/vim-quickrun",
    lazy = true,
  },
  -- https://github.com/tpope/vim-dispatch
  { "tpope/vim-dispatch" },
}
