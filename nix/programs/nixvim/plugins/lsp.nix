# LSP configuration (Mason is replaced by Nix package management)
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      inlayHints = true;

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
        # rust_analyzer is handled by rustaceanvim
        ruby_lsp.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        html.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        dockerls.enable = true;
        nil_ls.enable = true;
      };

      keymaps = {
        lspBuf = {
          gd = { action = "definition"; desc = "Go to definition"; };
          gD = { action = "declaration"; desc = "Go to declaration"; };
          gr = { action = "references"; desc = "Go to references"; };
          gI = { action = "implementation"; desc = "Go to implementation"; };
          gy = { action = "type_definition"; desc = "Go to type definition"; };
          K = { action = "hover"; desc = "Hover"; };
          gK = { action = "signature_help"; desc = "Signature help"; };
          "<leader>ca" = { action = "code_action"; desc = "Code action"; };
          "<leader>cr" = { action = "rename"; desc = "Rename"; };
        };
        extra = [
          { mode = "i"; key = "<C-k>"; action.__raw = "vim.lsp.buf.signature_help"; options.desc = "Signature help"; }
          { mode = "n"; key = "<leader>cf"; action.__raw = "function() vim.lsp.buf.format({ async = true }) end"; options.desc = "Format"; }
        ];
      };
    };

    plugins.lint = {
      enable = true;
      lintersByFt = {
        javascript = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        javascriptreact = [ "eslint_d" ];
        typescriptreact = [ "eslint_d" ];
      };
      autoCmd = {
        event = [ "BufWritePost" "BufReadPost" "InsertLeave" ];
        callback.__raw = ''
          function()
            require("lint").try_lint()
          end
        '';
      };
    };

    plugins.lazydev = {
      enable = true;
      settings.library = [
        { path = ''''${3rd}/luv/library''; words = [ "vim%.uv" ]; }
      ];
    };

    extraConfigLua = ''
      -- Diagnostics config
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    '';
  };

  # Install formatters via Nix (replaces Mason)
  home.packages = with pkgs; [
    stylua
    shfmt
    prettierd
    eslint_d
  ];
}
