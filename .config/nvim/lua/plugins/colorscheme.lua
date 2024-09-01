-- Colorschemes
return {
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    branch = "main",
    opts = {
      -- style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      day_brightness = 0.3,
    },
  },
  -- { 'sickill/vim-monokai' },
  -- { 'cocopon/iceberg.vim' },
  -- { 'KeitaNakamura/neodark.vim' },
  -- { 'EdenEast/nightfox.nvim' },
  -- { 'overcache/NeoSolarized' },
  -- { 'shaunsingh/nord.nvim' },
  -- { 'morhetz/gruvbox' },
  -- { 'rebelot/kanagawa.nvim' },
  -- { 'Mofiqul/vscode.nvim' },
}
