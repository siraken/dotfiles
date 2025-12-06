local opt = vim.opt

vim.scriptencoding = "utf-8"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Command line
opt.cmdheight = 1

-- Visual
opt.visualbell = true
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 5
opt.background = "dark"

-- Virtual edit & wildmenu
opt.virtualedit = "block"
opt.wildmenu = true
opt.wildignorecase = true
opt.wildoptions = "pum"

-- Indentation
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.encoding = "utf-8"
opt.fileencodings = "utf-8,euc-jp,sjis,latin"
opt.fileformats = "unix,dos,mac"

-- Misc
opt.compatible = false
opt.langmenu = "en_US"
opt.title = true
opt.ruler = true
opt.showcmd = true
opt.wrap = false
opt.backspace = "start,eol,indent"
opt.lazyredraw = false
opt.completeopt = "menu,menuone,noselect"
opt.scrolloff = 10
opt.inccommand = "split"
opt.signcolumn = "yes"
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.mouse = "a"
