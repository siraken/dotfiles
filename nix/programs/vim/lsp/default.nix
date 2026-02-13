{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gI" = "implementation";
            "gy" = "type_definition";
            "K" = "hover";
            "gK" = "signature_help";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
          };
          extra = [
            {
              mode = "i";
              key = "<C-k>";
              action.__raw = "vim.lsp.buf.signature_help";
              options.desc = "Signature help";
            }
            {
              mode = "n";
              key = "<leader>cf";
              action.__raw = "function() vim.lsp.buf.format({ async = true }) end";
              options.desc = "Format";
            }
          ];
        };
        servers = {
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                workspace.checkThirdParty = false;
                codeLens.enable = true;
                completion.callSnippet = "Replace";
              };
            };
          };
          ts_ls.enable = true;
          gopls.enable = true;
          pyright.enable = true;
          # rust_analyzer is managed by rustaceanvim
          ruby_lsp.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          dockerls.enable = true;
          nil_ls.enable = true;
        };
      };

      lint = {
        enable = true;
        lintersByFt = {
          javascript = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          javascriptreact = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
        };
      };

      lazydev = {
        enable = true;
        settings.library = [
          {
            path = "\${3rd}/luv/library";
            words = [ "vim%.uv" ];
          }
        ];
      };

      schemastore.enable = true;
    };

    extraPackages = with pkgs; [
      nodePackages.eslint_d
    ];

    extraConfigLua = builtins.readFile ./diagnostics.lua;
  };
}
