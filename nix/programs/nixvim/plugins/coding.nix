# Coding assistance plugins (formatting, pairing, comments)
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = [ "stylua" ];
          javascript = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          typescript = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          javascriptreact = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          typescriptreact = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          json = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          yaml = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          markdown = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          html = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          css = { __unkeyed-1 = "prettierd"; __unkeyed-2 = "prettier"; stop_after_first = true; };
          sh = [ "shfmt" ];
        };
        format_on_save = {
          timeout_ms = 3000;
          lsp_fallback = true;
        };
      };
    };

    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [ "TelescopePrompt" "vim" ];
      };
    };

    plugins.comment = {
      enable = true;
    };

    plugins.yanky = {
      enable = true;
      settings = {
        highlight.timer = 200;
      };
    };

    keymaps = [
      # Conform format injected
      {
        mode = [ "n" "v" ];
        key = "<leader>cF";
        action.__raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Langs";
      }

      # Yanky
      { mode = "n"; key = "<leader>p"; action.__raw = "function() require('fzf-lua').registers() end"; options.desc = "Paste from registers"; }
      { mode = [ "n" "x" ]; key = "y"; action = "<Plug>(YankyYank)"; options.desc = "Yank"; }
      { mode = [ "n" "x" ]; key = "p"; action = "<Plug>(YankyPutAfter)"; options.desc = "Put after"; }
      { mode = [ "n" "x" ]; key = "P"; action = "<Plug>(YankyPutBefore)"; options.desc = "Put before"; }
      { mode = "n"; key = "[y"; action = "<Plug>(YankyCycleForward)"; options.desc = "Cycle forward through yank history"; }
      { mode = "n"; key = "]y"; action = "<Plug>(YankyCycleBackward)"; options.desc = "Cycle backward through yank history"; }
    ];
  };
}
