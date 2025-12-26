# UI enhancement plugins
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          theme = "auto";
          globalstatus = true;
          component_separators = "";
          section_separators = "";
          disabled_filetypes = {
            statusline = [ "dashboard" "alpha" "neo-tree" ];
          };
        };
        sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [
            { __unkeyed-1 = "filename"; path = 1; color = { fg = "#7aa2f7"; }; }
          ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [
            { __unkeyed-1 = "location"; padding = { left = 1; right = 1; }; }
          ];
        };
        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [ { __unkeyed-1 = "filename"; path = 1; } ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [ ];
        };
        extensions = [ "neo-tree" "lazy" "trouble" "fzf" ];
      };
    };

    plugins.noice = {
      enable = true;
      settings = {
        cmdline = {
          enabled = true;
          view = "cmdline_popup";
        };
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
        };
        routes = [
          {
            filter = {
              event = "msg_show";
              any = [
                { find = "%d+L, %d+B"; }
                { find = "; after #%d+"; }
                { find = "; before #%d+"; }
              ];
            };
            view = "mini";
          }
        ];
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };
    };

    plugins.which-key = {
      enable = true;
      settings = {
        plugins.spelling = true;
        spec = [
          { __unkeyed-1 = "<leader>a"; group = "ai"; }
          { __unkeyed-1 = "<leader>b"; group = "buffer"; }
          { __unkeyed-1 = "<leader>c"; group = "code"; }
          { __unkeyed-1 = "<leader>f"; group = "file/find"; }
          { __unkeyed-1 = "<leader>g"; group = "git"; }
          { __unkeyed-1 = "<leader>q"; group = "quit/session"; }
          { __unkeyed-1 = "<leader>s"; group = "search"; }
          { __unkeyed-1 = "<leader>u"; group = "ui"; }
          { __unkeyed-1 = "<leader>w"; group = "windows"; }
          { __unkeyed-1 = "<leader>x"; group = "diagnostics/quickfix"; }
          { __unkeyed-1 = "["; group = "prev"; }
          { __unkeyed-1 = "]"; group = "next"; }
          { __unkeyed-1 = "g"; group = "goto"; }
        ];
      };
    };

    plugins.trouble = {
      enable = true;
      settings = {
        use_diagnostic_signs = true;
      };
    };

    plugins.todo-comments = {
      enable = true;
    };

    plugins.colorizer = {
      enable = true;
    };

    keymaps = [
      # Trouble
      { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<cr>"; options.desc = "Diagnostics (Trouble)"; }
      { mode = "n"; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"; options.desc = "Buffer Diagnostics (Trouble)"; }
      { mode = "n"; key = "<leader>cs"; action = "<cmd>Trouble symbols toggle focus=false<cr>"; options.desc = "Symbols (Trouble)"; }
      { mode = "n"; key = "<leader>xt"; action = "<cmd>Trouble todo toggle<cr>"; options.desc = "Todo (Trouble)"; }

      # Todo comments navigation
      { mode = "n"; key = "]t"; action.__raw = "function() require('todo-comments').jump_next() end"; options.desc = "Next todo comment"; }
      { mode = "n"; key = "[t"; action.__raw = "function() require('todo-comments').jump_prev() end"; options.desc = "Previous todo comment"; }
    ];
  };
}
