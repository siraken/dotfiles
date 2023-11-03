{ config, pkgs, ... }:

let
    username = "siraken";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

  # This should not be changed.
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    gh
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "siraken";
      # userEmail = "";
      aliases = {
        d = "diff";
        cm = "commit";
        co = "checkout";
        br = "branch";
        st = "status";
        ps = "push";
        pl = "pull";
        ad = "add";
        fe = "fetch";
        fedr = "fetch --dry-run";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        color = {
          status = "auto";
          diff = "auto";
          branch = "auto";
          interactive = "auto";
          grep = "auto";
          ui = "auto";
        };
        # ignore = {
          # macOS
          # .DS_Store
          # Windows
          # Thumbs.db
          # desktop.ini
        # };
      };
    },
    vim = {
      enable = true;
      settings = {
        # fileEncoding = "utf-8";
        nocompatible = true;
        # langmenu = "en_US.UTF-8";
        number = true;
        title = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        smarttab = true;
        smartindent = true;
        background = "dark";
        cmdheight = 1;
        ruler = true;
        cursorline = true;
        nobackup = true;
        hlsearch = true;
        ignorecase = true;
        showcmd = true;
        nowrap = true;
        backspace = "indent,eol,start";
        lazyredraw = true;
        completeopt = "menuone,noinsert";
        scrolloff = 10;
        # formatoptios += "r";
      };
      extraConfig = ''
      autocmd!
      set fileencodings=utf-8,sjis,euc-jp,latin
      scriptencoding utf-8
      filetype plugin indent on
      syntax enable

      " TypeScript React
      au BufNewFile,BufRead *.tsx setf typescriptreact
      " Markdown
      au BufNewFile,BufRead *.md set filetype=markdown
      au BufNewFile,BufRead *.mdx set filetype=markdown
      " Fish
      au BufNewFile,BufRead *.fish set filetype=fish
      " Ruby
      autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
      " yaml
      autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

      if exists("&termguicolors") && exists("&winblend")
        set termguicolors
        set winblend=0
        set wildoptions=pum
        set pumblend=5
        set background=dark
      endif

      highlight CurrLine ctermbg=magenta cterm=bold ctermfg=white

      let $LANG = 'en_US'
      '';
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    tmux = {
      enable = true;
    };
    # fish = {
    #   enable = true;
    # };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    }
  };

}
