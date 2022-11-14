local opt = vim.opt
local api = vim.api
local wo = vim.wo
local bo = vim.bo

vim.cmd('autocmd!')
vim.scriptencoding = 'utf-8'

wo.number = true
opt.cmdheight = 1

opt.virtualedit = 'block'
opt.wildmenu = true
opt.wildignorecase = true

opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.swapfile = false
opt.backup = false
opt.encoding = 'utf-8'
opt.fileencodings = 'utf-8,sjis,euc-jp,latin'

opt.compatible = false
opt.langmenu = 'en_US'
opt.title = true
opt.background = 'dark'
opt.ruler = true
opt.showcmd = true
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
opt.mouse = ''

api.nvim_command [[syntax enable]]
api.nvim_command [[colorscheme tokyonight]]

-- nvim-tree
vim.keymap.set('n', 'tr', '<cmd>NvimTreeToggle<cr>')
-- vim.cmd(':command Tr NvimTreeToggle')

-- Prettier
vim.g['prettier#autoformat'] = 1
vim.g['prettier#autoformat_require_pragma'] = 0

-- Rust format
vim.g['rustfmt_autosave'] = 1

-- vim-go no template
vim.g['go_template_autocreate'] = 0

-- ale_linters
-- vim.g['ale_linters'] = {
--
-- }

-- Insert mode in terminal
vim.cmd [[autocmd TermOpen * startinsert]]

-- let $LANG = 'en_US'
