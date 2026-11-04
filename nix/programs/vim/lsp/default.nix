{ ... }:
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
          # JS / TS lint, only in projects that opt in (.oxlintrc.json, or
          # oxlint in package.json), as eslint_d needed an ESLint config.
          # lspconfig's root_dir passes nil when no marker is found, and
          # Neovim then starts the server rootless with default rules;
          # workspace_required keeps it off in that case.
          oxlint = {
            enable = true;
            extraOptions.workspace_required = true;
          };
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

    extraConfigLua =
      builtins.readFile ./diagnostics.lua + "\n" + builtins.readFile ./document-color.lua;
  };
}
