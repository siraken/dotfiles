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
opt.background = 'dark'
-- opt.formatoptions += 'r'

api.nvim_command [[syntax enable]]
api.nvim_command [[colorscheme monokai]]

g['airline_theme'] = 'molokai'

g['airline#extensions#tabline#enabled'] = 1
g['airline_powerline_fonts'] = 1

g['NERDTreeWinSize'] = 24

g['prettier#autoformat'] = 1
g['prettier#autoformat_require_pragma'] = 0

g['rustfmt_autosave'] = 1

g['go_template_autocreate'] = 0

g['coc_global_extensions'] = {
  'coc-go',
  'coc-html',
  'coc-json',
  'coc-sh',
  'coc-tailwindcss',
  'coc-tsserver',
  'coc-blade',
  'coc-yaml',
  'coc-java',
  'coc-markdownlint',
  'coc-spell-checker',
  'coc-highlight',
  'coc-git',
  'coc-deno',
  'coc-pyright',
  'coc-vetur',
  'coc-kotlin',
  'coc-rls',
  'coc-flutter',
  '@yaegassy/coc-intelephense',
}

-- let $LANG = 'en_US'

-- :command Tr NERDTree
