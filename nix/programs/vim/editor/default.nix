{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      mini-icons.enable = true;

      mini-ai = {
        enable = true;
        settings.n_lines = 500;
      };

      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          dashboard.enabled = false;
          indent.enabled = false;
          input.enabled = true;
          notifier.enabled = true;
          quickfile.enabled = true;
          scroll.enabled = false;
          statuscolumn.enabled = false;
          words.enabled = true;
        };
      };

      flash = {
        enable = true;
        settings.modes = {
          char.enabled = false;
          search.enabled = false;
          treesitter.enabled = false;
        };
      };

      fzf-lua = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [ "FzfLua" ];
        };
        settings = {
          "__unkeyed-1" = "default-title";
          fzf_colors = true;
          defaults.formatter = "path.filename_first";
        };
      };

      grug-far = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [ "GrugFar" ];
        };
        settings.headerMaxWidth = 80;
      };

      neo-tree = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [ "Neotree" ];
        };
        settings = {
          filesystem = {
            bind_to_cwd = false;
            follow_current_file.enabled = true;
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

      persistence = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.event = [ "DeferredUIEnter" ];
        };
      };
    };

    extraPackages = with pkgs; [
      fzf
    ];

    keymaps = [
      # flash
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<CR>";
        action.__raw = ''
          function()
            require("flash").jump({ label = { before = true, after = false } })
          end
        '';
        options.desc = "Flash";
      }
      # fzf-lua
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>FzfLua files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>FzfLua oldfiles<cr>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>FzfLua grep_cword<cr>";
        options.desc = "Grep word";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua help_tags<cr>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>FzfLua commands<cr>";
        options.desc = "Commands";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<cmd>FzfLua marks<cr>";
        options.desc = "Marks";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>FzfLua live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>FzfLua live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>FzfLua grep_cword<cr>";
        options.desc = "Grep word";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>FzfLua lsp_document_symbols<cr>";
        options.desc = "Document symbols";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action = "<cmd>FzfLua lsp_workspace_symbols<cr>";
        options.desc = "Workspace symbols";
      }
      # neo-tree
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Explorer (Neo-tree)";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Explorer (Neo-tree)";
      }
      # grug-far
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>GrugFar<cr>";
        options.desc = "Search and Replace";
      }
      # persistence
      {
        mode = "n";
        key = "<leader>qs";
        action.__raw = ''function() require("persistence").load() end'';
        options.desc = "Restore Session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action.__raw = ''function() require("persistence").load({ last = true }) end'';
        options.desc = "Restore Last Session";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action.__raw = ''function() require("persistence").stop() end'';
        options.desc = "Don't Save Current Session";
      }
    ];
  };
}
