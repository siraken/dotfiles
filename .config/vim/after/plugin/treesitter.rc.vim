if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
require 'nvim-treesitter.configs'.setup {
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
EOF

