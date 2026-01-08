return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.icons",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
    { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
        hide_gitignored = false,
        hide_by_name = { ".git" },
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
    },
  },
}
