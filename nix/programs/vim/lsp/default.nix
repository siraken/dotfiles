{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        keymaps = {
          # References, rename, code action, implementation and type
          # definition also have Neovim's default gr* maps (grr, grn, gra,
          # gri, grt). A plain `gr` here would make those wait timeoutlen.
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
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
          ];
        };
        servers = {
          lua_ls = {
            enable = true;
            # Nixvim nests these under `Lua` itself; writing `Lua = { … }`
            # here produced `Lua.Lua` and the settings were ignored.
            settings = {
              workspace.checkThirdParty = false;
              codeLens.enable = true;
              completion.callSnippet = "Replace";
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
        lazyLoad = {
          enable = true;
          settings.ft = [ "lua" ];
        };
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
      eslint_d
    ];

    extraConfigLua =
      builtins.readFile ./diagnostics.lua + "\n" + builtins.readFile ./document-color.lua;
  };
}
