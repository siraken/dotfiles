return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  cmd = "FzfLua",
  keys = {
    { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep Word" },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
    { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep Word" },
    { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
  },
  opts = {
    "default-title",
    fzf_colors = true,
    defaults = {
      formatter = "path.filename_first",
    },
  },
}
