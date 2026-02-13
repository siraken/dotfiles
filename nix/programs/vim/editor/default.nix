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
        settings = {
          "__unkeyed-1" = "default-title";
          fzf_colors = true;
          defaults.formatter = "path.filename_first";
        };
        keymaps = {
          "<leader><space>" = "files";
          "<leader>ff" = "files";
          "<leader>fr" = "oldfiles";
          "<leader>fb" = "buffers";
          "<leader>fg" = "live_grep";
          "<leader>fw" = "grep_cword";
          "<leader>fh" = "help_tags";
          "<leader>fc" = "commands";
          "<leader>fm" = "marks";
          "<leader>/" = "live_grep";
          "<leader>sg" = "live_grep";
          "<leader>sw" = "grep_cword";
          "<leader>ss" = "lsp_document_symbols";
          "<leader>sS" = "lsp_workspace_symbols";
        };
      };

      grug-far = {
        enable = true;
        settings.headerMaxWidth = 80;
      };

      neo-tree = {
        enable = true;
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

      persistence.enable = true;
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
