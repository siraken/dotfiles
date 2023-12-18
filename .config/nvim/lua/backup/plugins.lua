-- Install lazy.nvim automatically if not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins definition
local plugins = {
  -- Neovim LSP
  { 'neovim/nvim-lspconfig' },
  -- Mason: LSP client for Neovim
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  --
  -- Colorschemes
  --
  { 'folke/tokyonight.nvim', lazy = false, branch = 'main' },
  -- { 'sickill/vim-monokai' },
  -- { 'cocopon/iceberg.vim' },
  -- { 'KeitaNakamura/neodark.vim' },
  -- { 'EdenEast/nightfox.nvim' },
  -- { 'overcache/NeoSolarized' },
  -- { 'shaunsingh/nord.nvim' },
  -- { 'morhetz/gruvbox' },
  -- { 'rebelot/kanagawa.nvim' },
  -- { 'Mofiqul/vscode.nvim' },
  --
  -- Language support
  --
  { 'tomlion/vim-solidity' },
  { 'ziglang/zig.vim' },
  { 'editorconfig/editorconfig-vim' },
  { 'OmniSharp/omnisharp-vim' },
  { 'udalov/kotlin-vim' },
  { 'akinsho/flutter-tools.nvim' },
  { 'wuelnerdotexe/vim-astro' },
  -- FIXME: rtp can be accomplished.
  -- Read: https://github.com/folke/lazy.nvim#-migration-guide
  { 'vlime/vlime', rtp = 'vim' },
  { 'vim-scripts/paredit.vim' },
  { 'Olical/conjure', ft = { 'clojure' } },
  { 'tpope/vim-dispatch' },
  { 'clojure-vim/vim-jack-in' },
  { 'radenling/vim-dispatch-neovim' },
  { 'roobert/tailwindcss-colorizer-cmp.nvim' },
  { 'scalameta/nvim-metals', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'sheerun/vim-polyglot' },
  --
  -- LSP-related
  --
  { 'onsails/lspkind.nvim' }, -- VSCode-like pictograms
  { 'nvimdev/lspsaga.nvim' }, -- LSP UIs
  -- { 'jose-elias-alvarez/null-ls.nvim' }, -- ARCHIVED
  { 'nvimtools/none-ls.nvim' }, -- Alternative of above?
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
  { 'ray-x/lsp_signature.nvim' },
  { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  --
  -- Completion
  --
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
    }
  },
  { 'L3MON4D3/LuaSnip' },
  ---
  --- Debugging
  ---
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      { 'mfussenegger/nvim-dap' }
    }
  },
  { 'theHamsta/nvim-dap-virtual-text' },
  --
  -- UI for messages, cmdline, popup, etc.
  --
  {
    'folke/noice.nvim',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' } -- for notifications
    }
  },
  { 'RRethy/vim-illuminate' },
  --
  -- Display style
  --
  { 'mhinz/vim-startify' },        -- Startup screen
  { 'nvim-lualine/lualine.nvim' }, -- Statusline
  { 'norcalli/nvim-colorizer.lua' },
  { 'folke/trouble.nvim' },
  { 'lewis6991/gitsigns.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'akinsho/bufferline.nvim',            version = '*' }, -- Tab
  --
  -- Utilities
  --
  { 'github/copilot.vim' },
  { 'itchyny/calendar.vim' },
  { 'pwntester/octo.nvim' },
  { 'dhruvasagar/vim-table-mode' },
  { 'dstein64/vim-startuptime' },
  { 'numToStr/Comment.nvim' },
  { 'folke/todo-comments.nvim' },
  { 'guns/vim-sexp' },
  { 'thinca/vim-quickrun' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require('telescope').load_extension 'frecency'
    end,
  },
  --
  -- Uncategorized yet
  --
  { 'mg979/vim-visual-multi' },
  { 'folke/which-key.nvim' },
  { 'folke/neodev.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'windwp/nvim-autopairs' },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn['mkdp#util#install']() end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*'
  },
  --
  -- Homebrew
  --
  -- { 'siraken/html-parser.vim' }
}

-- Lazy configuration
local opts = {}

-- FIXME: E492: Not an editor command: Lazy
require('lazy').setup(plugins, opts)
