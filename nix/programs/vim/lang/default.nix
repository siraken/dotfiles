{ ... }:
{
  programs.nixvim = {
    plugins = {
      # Rust
      rustaceanvim = {
        enable = true;
        settings.server = {
          on_attach.__raw = builtins.readFile ./rustaceanvim-on-attach.lua;
          default_settings = {
            "rust-analyzer" = {
              cargo = {
                allFeatures = true;
                loadOutDirsFromCheck = true;
                buildScripts.enable = true;
              };
              checkOnSave = true;
              procMacro = {
                enable = true;
                ignored = {
                  "async-trait" = [ "async_trait" ];
                  "napi-derive" = [ "napi" ];
                  "async-recursion" = [ "async_recursion" ];
                };
              };
            };
          };
        };
      };

      crates = {
        enable = true;
        settings.completion.crates.enabled = true;
      };

      # Python
      venv-selector.enable = true;

      # Markdown
      markdown-preview.enable = true;

      render-markdown = {
        enable = true;
        settings = {
          code = {
            sign = false;
            width = "block";
            right_pad = 1;
          };
          heading = {
            sign = false;
            icons = [ ];
          };
          file_types = [
            "markdown"
            "norg"
            "rmd"
            "org"
          ];
        };
      };

      # Java
      jdtls.enable = true;

      # Clojure/Lisp
      conjure.enable = true;
    };

    globals."conjure#mapping#doc_word" = "K";

    keymaps = [
      {
        mode = "n";
        key = "<leader>cv";
        action = "<cmd>VenvSelect<cr>";
        options.desc = "Select VirtualEnv";
      }
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options.desc = "Markdown Preview";
      }
    ];
  };
}
