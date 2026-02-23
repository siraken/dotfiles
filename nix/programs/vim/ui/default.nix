{ ... }:
{
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true;
        terminal_colors = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
        day_brightness = 0.3;
      };
    };

    plugins = {
      web-devicons.enable = true;
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
            globalstatus = true;
            component_separators = "";
            section_separators = "";
            disabled_filetypes.statusline = [
              "dashboard"
              "alpha"
              "neo-tree"
            ];
          };
          sections = {
            lualine_a = [ ];
            lualine_b = [ ];
            lualine_c = [
              {
                "__unkeyed-1" = "filename";
                path = 1;
                color.fg = "#7aa2f7";
              }
            ];
            lualine_x = [ ];
            lualine_y = [ ];
            lualine_z = [
              {
                "__unkeyed-1" = "location";
                padding = {
                  left = 1;
                  right = 1;
                };
              }
            ];
          };
          inactive_sections = {
            lualine_a = [ ];
            lualine_b = [ ];
            lualine_c = [
              {
                "__unkeyed-1" = "filename";
                path = 1;
              }
            ];
            lualine_x = [ ];
            lualine_y = [ ];
            lualine_z = [ ];
          };
          extensions = [
            "neo-tree"
            "lazy"
            "trouble"
            "fzf"
          ];
        };
      };

      which-key = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.event = [ "DeferredUIEnter" ];
        };
        settings = {
          plugins.spelling = true;
          spec = [
            {
              "__unkeyed-1" = "<leader>a";
              group = "ai";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>b";
              group = "buffer";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>c";
              group = "code";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>f";
              group = "file/find";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>g";
              group = "git";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>q";
              group = "quit/session";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>s";
              group = "search";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>u";
              group = "ui";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>w";
              group = "windows";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "<leader>x";
              group = "diagnostics/quickfix";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "[";
              group = "prev";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "]";
              group = "next";
              mode = [
                "n"
                "v"
              ];
            }
            {
              "__unkeyed-1" = "g";
              group = "goto";
              mode = [
                "n"
                "v"
              ];
            }
          ];
        };
      };

      colorizer.enable = true;

      noice = {
        enable = true;
        settings = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
          };
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
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

      trouble = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [ "Trouble" ];
        };
        settings.use_diagnostic_signs = true;
      };

      todo-comments.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "]t";
        action.__raw = ''function() require("todo-comments").jump_next() end'';
        options.desc = "Next todo comment";
      }
      {
        mode = "n";
        key = "[t";
        action.__raw = ''function() require("todo-comments").jump_prev() end'';
        options.desc = "Previous todo comment";
      }
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>Trouble todo toggle<cr>";
        options.desc = "Todo (Trouble)";
      }
    ];
  };
}
