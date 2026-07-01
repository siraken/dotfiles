{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      comment.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            javascript = [ "biome" ];
            typescript = [ "biome" ];
            javascriptreact = [ "biome" ];
            typescriptreact = [ "biome" ];
            json = [ "biome" ];
            css = [ "biome" ];
            sh = [ "shfmt" ];
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
          disable_filetype = [
            "TelescopePrompt"
            "vim"
          ];
        };
      };

      yanky = {
        enable = true;
        settings.highlight.timer = 200;
      };
    };

    extraPackages = with pkgs; [
      stylua
      biome
      shfmt
    ];

    keymaps = [
      {
        mode = [
          "n"
          "v"
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
