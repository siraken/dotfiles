{ pkgs, ... }:
{
  imports = [
    ./ai
    ./coding
    ./completion
    ./editor
    ./git
    ./lang
    ./lsp
    ./treesitter
    ./ui
  ];

  programs.nixvim = {
    enable = true;

    # Plugins NOT available in Nixvim (need extraPlugins if desired):
    # - nvim-paredit (julienvincent/nvim-paredit) - S-expression editing
    # - vim-dispatch (tpope/vim-dispatch) - Async command execution
    # - vim-quickrun (thinca/vim-quickrun) - Quick script execution
    # - vim-slim (slim-template/vim-slim) - Slim template language
    # - vim-jack-in (clojure-vim/vim-jack-in) - Clojure REPL jack-in
    # - vlime (vlime/vlime) - Common Lisp IDE
    # - omnisharp-extended-lsp.nvim (Hoffs/omnisharp-extended-lsp.nvim) - C# LSP
    # - tailwindcss-colorizer-cmp.nvim (roobert/tailwindcss-colorizer-cmp.nvim)
    # - calendar.vim (itchyny/calendar.vim) - Calendar display
    #
    # Plugins NOT needed with Nixvim:
    # - lazy.nvim (Nixvim manages plugins)
    # - mason.nvim / mason-lspconfig.nvim (Nix manages LSP servers/tools)
    # - plenary.nvim / nui.nvim (auto-included as dependencies)
    # - editorconfig-vim (built-in to Neovim 0.9+)

    # ── Global variables ──
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # ── Options (from options.lua) ──
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Command line (0 = use noice.nvim for cmdline)
      cmdheight = 0;

      # Visual
      visualbell = true;
      cursorline = true;
      termguicolors = true;
      winblend = 0;
      pumblend = 5;
      background = "dark";

      # Virtual edit & wildmenu
      virtualedit = "block";
      wildmenu = true;
      wildignorecase = true;
      wildoptions = "pum";

      # Indentation
      tabstop = 2;
      expandtab = true;
      shiftwidth = 2;
      smarttab = true;
      autoindent = true;
      smartindent = true;

      # Search
      hlsearch = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;

      # Files
      swapfile = false;
      backup = false;
      encoding = "utf-8";
      fileencodings = "utf-8,euc-jp,sjis,latin";
      fileformats = "unix,dos,mac";

      # Misc
      compatible = false;
      langmenu = "en_US";
      title = true;
      ruler = true;
      showcmd = true;
      wrap = false;
      backspace = "start,eol,indent";
      lazyredraw = false;
      completeopt = "menu,menuone,noselect";
      scrolloff = 10;
      inccommand = "split";
      signcolumn = "auto";
      clipboard = "unnamedplus";
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      timeoutlen = 300;
      splitbelow = true;
      splitright = true;
      splitkeep = "screen";
      mouse = "a";
    };

    # ── Global keymaps (from keymaps.lua) ──
    keymaps = [
      # Increment / decrement
      {
        mode = "n";
        key = "+";
        action = "<C-a>";
      }
      {
        mode = "n";
        key = "-";
        action = "<C-x>";
      }
      # Select all
      {
        mode = "n";
        key = "<C-a>";
        action = "gg<S-v>G";
      }
      # Split window
      {
        mode = "n";
        key = "ss";
        action = "<cmd>split<cr><C-w>w";
        options.desc = "Split horizontal";
      }
      {
        mode = "n";
        key = "sv";
        action = "<cmd>vsplit<cr><C-w>w";
        options.desc = "Split vertical";
      }
      # Move window
      {
        mode = "n";
        key = "sh";
        action = "<C-w>h";
        options.desc = "Go to left window";
      }
      {
        mode = "n";
        key = "sk";
        action = "<C-w>k";
        options.desc = "Go to upper window";
      }
      {
        mode = "n";
        key = "sj";
        action = "<C-w>j";
        options.desc = "Go to lower window";
      }
      {
        mode = "n";
        key = "sl";
        action = "<C-w>l";
        options.desc = "Go to right window";
      }
      # Resize window
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase width";
      }
      # Close buffer
      {
        mode = "n";
        key = "<leader>bd";
        action.__raw = ''function() require("snacks").bufdelete() end'';
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>:bd<cr>";
        options.desc = "Delete buffer and window";
      }
      # Redo
      {
        mode = "n";
        key = "U";
        action = "<C-r>";
        options.desc = "Redo";
      }
      # Reselect visual block after indents
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
      # Tab / Shift+Tab
      {
        mode = "i";
        key = "<S-Tab>";
        action = "<C-d>";
      }
      {
        mode = "v";
        key = "<Tab>";
        action = ">>";
      }
      {
        mode = "v";
        key = "<S-Tab>";
        action = "<<";
      }
      # Stay visual mode after formatting
      {
        mode = "v";
        key = "=";
        action = "=gv";
      }
      # Better up/down (wrap-aware)
      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }
      # Move lines
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move up";
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        options.desc = "Move down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        options.desc = "Move up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move up";
      }
      # Clear search with <esc>
      {
        mode = [
          "i"
          "n"
        ];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options.desc = "Escape and clear search";
      }
      # Quit all
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit all";
      }
      # New file
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options.desc = "New file";
      }
      # Diagnostic navigation
      {
        mode = "n";
        key = "]d";
        action.__raw = "vim.diagnostic.goto_next";
        options.desc = "Next diagnostic";
      }
      {
        mode = "n";
        key = "[d";
        action.__raw = "vim.diagnostic.goto_prev";
        options.desc = "Prev diagnostic";
      }
      {
        mode = "n";
        key = "<leader>cd";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Line diagnostics";
      }
      # UI toggles
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = ''
          function()
            vim.wo.number = not vim.wo.number
            vim.wo.relativenumber = not vim.wo.relativenumber
          end
        '';
        options.desc = "Toggle line numbers";
      }
      {
        mode = "n";
        key = "<leader>ui";
        action.__raw = builtins.readFile ./lua/keymap-file-info.lua;
        options.desc = "Show file info";
      }
    ];

    # ── Autocommands & extra config (from autocmds.lua) ──
    extraConfigLua =
      builtins.readFile ./lua/autocmds.lua + "\n" + builtins.readFile ./lua/extra-config.lua;
  };

  programs.vim = {
    enable = true;
    settings = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Indentation
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # Appearance
      background = "dark";

      # Undo
      undofile = false;
    };

    extraConfig = ''
      autocmd!

      scriptencoding utf-8
      filetype plugin indent on
      syntax enable
      colorscheme industry

      set nocompatible

      set signcolumn=yes
      set laststatus=2
      set cmdheight=1
      set showtabline=2

      set virtualedit=block
      set wildmenu
      set wildignorecase

      set smartindent

      set hlsearch
      set incsearch

      set noswapfile
      set nobackup
      set encoding=utf-8
      set fileencodings=euc-jp,sjis,latin,utf-8
      set fileformats=unix,dos,mac

      set title
      set smarttab
      set ruler
      set cursorline
      set showcmd
      set nowrap
      set backspace=start,eol,indent
      set lazyredraw
      set completeopt=menuone,noinsert
      set scrolloff=10
      set formatoptions+=r
      set langmenu=en_US

      " Increment / decrement
      nnoremap + <C-a>
      nnoremap - <C-x>

      " Select all
      nnoremap <C-a> gg<S-v>G

      " Spit window
      nnoremap ss :split<CR><C-W>w
      nnoremap sv :vsplit<CR><C-w>w

      " Move window
      nnoremap <Space> <C-w>w
      noremap sh <C-w>h
      noremap sk <C-w>k
      noremap sj <C-w>j
      noremap sl <C-w>l

      " Resize window
      nnoremap <C-w><left> <C-w><
      nnoremap <C-w><right> <C-w>>
      nnoremap <C-w><up> <C-w>+
      nnoremap <C-w><down> <C-w>-

      " Close buffer
      nnoremap <C-w>q :bd<CR>

      " Use Shift + U as redo
      nnoremap U <C-r>

      " Reselect visual block after indents
      xnoremap < <gv
      xnoremap > >gv

      " Use Tab, Shift + Tab
      inoremap <S-Tab> <C-d>
      xnoremap <Tab> >gv
      xnoremap <S-Tab> <gv

      " Auto close brackets
      inoremap ( ()<Left>
      inoremap { {}<Left>
      inoremap [ []<Left>

      " Stay visual mode after formatting
      xnoremap = =gv

      let $LANG = 'en_US'
    '';
  };
}
