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
    -- A to Z
    "bash",
    "c",
    "c_sharp",
    "clojure",
    "comment",
    "commonlisp",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "elixir",
    "fish",
    "go",
    "gomod",
    "graphql",
    -- "hack",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "kotlin",
    "lua",
    "perl",
    "php",
    -- "phpdoc", -- npm error
    "pug",
    "python",
    "ruby",
    "rust",
    "scala",
    "scss",
    "solidity",
    "sql",
    "svelte",
    "swift",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "zig",
  }
}
