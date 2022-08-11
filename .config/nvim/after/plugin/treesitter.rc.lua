local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "vue",
    "c",
    "ruby",
    "kotlin",
    "python",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "rust",
    "go",
    "gomod",
    "html",
    "scss",
  }
}
