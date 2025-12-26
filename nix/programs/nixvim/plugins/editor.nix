# Editor plugins (file tree, navigation, search)
{ pkgs, ... }:
let
  grug-far-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "grug-far-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "MagicDuck";
      repo = "grug-far.nvim";
      rev = "74eef260e1142264ab994fb9c88e4f420e9486d7";
      hash = "sha256-7ONjxDI5wy63TpIQyZyKVFTi9tA0QOGmF9iDaPILMyw=";
    };
  };
in
{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings = {
        sources = [ "filesystem" "buffers" "git_status" ];
        filesystem = {
          bind_to_cwd = false;
          follow_current_file = { enabled = true; };
          use_libuv_file_watcher = true;
          filtered_items = {
            hide_dotfiles = false;
            hide_hidden = false;
            hide_gitignored = false;
            hide_by_name = [ ".git" ];
          };
        };
        window.mappings."<space>" = "none";
        default_component_configs.indent.with_expanders = true;
      };
    };

    plugins.fzf-lua = {
      enable = true;
      settings = {
        "default-title" = true;
        fzf_colors = true;
        defaults.formatter = "path.filename_first";
      };
    };

    plugins.flash = {
      enable = true;
      settings.modes = {
        char.enabled = false;
        search.enabled = false;
        treesitter.enabled = false;
      };
    };

    plugins.persistence.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      vim-quickrun
      vim-dispatch
      editorconfig-vim
      grug-far-nvim
    ];

    extraConfigLua = ''
      require("grug-far").setup({ headerMaxWidth = 80 })
    '';

    keymaps = [
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Explorer (Neo-tree)"; }
      { mode = "n"; key = "<leader>fe"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Explorer (Neo-tree)"; }
      { mode = "n"; key = "<leader><space>"; action = "<cmd>FzfLua files<cr>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>ff"; action = "<cmd>FzfLua files<cr>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fr"; action = "<cmd>FzfLua oldfiles<cr>"; options.desc = "Recent Files"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>FzfLua buffers<cr>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>FzfLua live_grep<cr>"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>fw"; action = "<cmd>FzfLua grep_cword<cr>"; options.desc = "Grep Word"; }
      { mode = "n"; key = "<leader>fh"; action = "<cmd>FzfLua help_tags<cr>"; options.desc = "Help"; }
      { mode = "n"; key = "<leader>fc"; action = "<cmd>FzfLua commands<cr>"; options.desc = "Commands"; }
      { mode = "n"; key = "<leader>fm"; action = "<cmd>FzfLua marks<cr>"; options.desc = "Marks"; }
      { mode = "n"; key = "<leader>/"; action = "<cmd>FzfLua live_grep<cr>"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>sg"; action = "<cmd>FzfLua live_grep<cr>"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>sw"; action = "<cmd>FzfLua grep_cword<cr>"; options.desc = "Grep Word"; }
      { mode = "n"; key = "<leader>ss"; action = "<cmd>FzfLua lsp_document_symbols<cr>"; options.desc = "Document Symbols"; }
      { mode = "n"; key = "<leader>sS"; action = "<cmd>FzfLua lsp_workspace_symbols<cr>"; options.desc = "Workspace Symbols"; }
      {
        mode = [ "n" "x" "o" ];
        key = "<CR>";
        action.__raw = ''function() require("flash").jump({ label = { before = true, after = false } }) end'';
        options.desc = "Flash";
      }
      { mode = "n"; key = "<leader>sr"; action = "<cmd>GrugFar<cr>"; options.desc = "Search and Replace"; }
      { mode = "n"; key = "<leader>qs"; action.__raw = "function() require('persistence').load() end"; options.desc = "Restore Session"; }
      { mode = "n"; key = "<leader>ql"; action.__raw = "function() require('persistence').load({ last = true }) end"; options.desc = "Restore Last Session"; }
      { mode = "n"; key = "<leader>qd"; action.__raw = "function() require('persistence').stop() end"; options.desc = "Don't Save Current Session"; }
    ];
  };
}
