# Vim options configuration
{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

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
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      timeoutlen = 300;
      splitbelow = true;
      splitright = true;
      splitkeep = "screen";
      mouse = "a";
    };

    # Platform-specific clipboard configuration
    extraConfigLua = ''
      vim.scriptencoding = "utf-8"
      vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

      -- Neovide GUI settings
      if vim.g.neovide then
        vim.g.neovide_transparency = 0.5
        vim.g.transparency = 0.8
        vim.g.neovide_background_color = "#0f1117" .. string.format("%x", math.floor(255 * 0.8))
        vim.g.neovide_window_blurred = true
        vim.g.neovide_floating_shadow = true
        vim.g.neovide_floating_shadow_amount_x = 2.0
        vim.g.neovide_floating_shadow_amount_y = 2.0
        vim.g.neovide_light_radius = 5
      end
    '';
  };
}
