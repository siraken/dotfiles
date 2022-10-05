local opt = vim.opt
local api = vim.api
local wo = vim.wo
local bo = vim.bo
local g = vim.g

vim.cmd('autocmd!')
vim.scriptencoding = 'utf-8'

wo.number = true

opt.fileencodings = 'utf-8,sjis,euc-jp,latin'
opt.compatible = false
opt.langmenu = 'en_US'
opt.title = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.background = 'dark'
opt.cmdheight = 1
opt.ruler = true
opt.backup = false
opt.hlsearch = true
opt.ignorecase = true
opt.showcmd = true
opt.encoding = 'utf-8'
opt.wrap = false
opt.backspace = 'start,eol,indent'
opt.lazyredraw = true
opt.completeopt = 'menuone,noinsert'
opt.scrolloff = 10
opt.inccommand = 'split'
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumblend = 5
opt.shellslash = true
-- opt.mouse = 'a'

api.nvim_command [[syntax enable]]
api.nvim_command [[colorscheme tokyonight]]

-- nvim-tree
vim.cmd(':command Tr NvimTreeToggle')

-- Prettier
g['prettier#autoformat'] = 1
g['prettier#autoformat_require_pragma'] = 0

-- Rust format
g['rustfmt_autosave'] = 1

-- vim-go no template
g['go_template_autocreate'] = 0

-- let $LANG = 'en_US'
