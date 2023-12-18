local opt = vim.opt
local api = vim.api
local wo = vim.wo
local bo = vim.bo
local vscode = vim.g.vscode

vim.scriptencoding = "utf-8"

wo.number = true
wo.relativenumber = false

opt.cmdheight = 1

opt.visualbell = true

opt.virtualedit = "block"
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
opt.encoding = "utf-8"
opt.fileencodings = "utf-8,euc-jp,sjis,latin"
opt.fileformats = "unix,dos,mac"

opt.compatible = false
opt.langmenu = "en_US"
opt.title = true
opt.background = "dark"
opt.ruler = true
opt.showcmd = true
opt.wrap = false
opt.backspace = "start,eol,indent"
opt.lazyredraw = false
opt.completeopt = "menuone,noinsert"
opt.scrolloff = 10
opt.inccommand = "split"
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = "pum"
opt.pumblend = 5
-- opt.shellslash = true

api.nvim_command([[language en_US.UTF-8]])
api.nvim_command([[syntax enable]])

vim.cmd([[autocmd TermOpen * startinsert]])

if not vscode then
  vim.keymap.set("n", "tr", "<Cmd>NvimTreeToggle<CR>")
else
  vim.keymap.set("n", "tr", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>")
  vim.keymap.set("n", "tr", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
end
