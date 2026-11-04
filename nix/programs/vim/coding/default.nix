{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            javascript = [ "oxfmt" ];
            typescript = [ "oxfmt" ];
            javascriptreact = [ "oxfmt" ];
            typescriptreact = [ "oxfmt" ];
            json = [ "oxfmt" ];
            css = [ "oxfmt" ];
            sh = [ "shfmt" ];
            # Same formatter as this repo's treefmt; nil_ls does not format
            # unless given a formatting command.
            nix = [ "nixfmt" ];
          };
          format_on_save = {
            timeout_ms = 3000;
            lsp_format = "fallback";
          };
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          disable_filetype = [ "vim" ];
        };
      };

      yanky = {
        enable = true;
        settings.highlight.timer = 200;
      };
    };

    extraPackages = with pkgs; [
      stylua
      oxfmt
      shfmt
      nixfmt
    ];

    keymaps = [
      # Format through conform, like format-on-save, so a manual format and a
      # save produce the same result (e.g. oxfmt rather than ts_ls).
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cf";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end
        '';
        options.desc = "Format";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cF";
        action.__raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Langs";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "y";
        action = "<Plug>(YankyYank)";
        options.desc = "Yank";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        options.desc = "Put after";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        options.desc = "Put before";
      }
      {
        mode = "n";
        key = "[y";
        action = "<Plug>(YankyCycleForward)";
        options.desc = "Cycle forward through yank history";
      }
      {
        mode = "n";
        key = "]y";
        action = "<Plug>(YankyCycleBackward)";
        options.desc = "Cycle backward through yank history";
      }
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>FzfLua registers<cr>";
        options.desc = "Paste from registers";
      }
    ];
  };
}
