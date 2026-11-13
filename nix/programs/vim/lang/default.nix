{ pkgs, ... }:
let
  # norg / rmd / org were listed too, but there is no tree-sitter grammar for
  # them in ../treesitter, so render-markdown did nothing there.
  markdownFileTypes = [ "markdown" ];
in
{
  programs.nixvim = {
    plugins = {
      # Rust
      rustaceanvim = {
        enable = true;
        # Nixvim builds its own pkgs from `nixpkgs.source` without our
        # overlays, so take the plugin from the overlaid home-manager pkgs to
        # pick up the Darwin test skip in nix/lib/overlays.nix. Drop together
        # with that overlay.
        package = pkgs.vimPlugins.rustaceanvim;
        lazyLoad = {
          enable = true;
          settings.ft = [ "rust" ];
        };
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
        lazyLoad = {
          enable = true;
          settings.ft = [ "toml" ];
        };
        # The in-process LSP is how crates.nvim feeds blink.cmp (its cmp
        # source is deprecated); completion.crates.enabled is already the default.
        settings.lsp = {
          enabled = true;
          completion = true;
          actions = true;
          hover = true;
        };
      };

      # Python
      venv-selector = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [ "VenvSelect" ];
        };
      };

      # Markdown
      markdown-preview = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.cmd = [
            "MarkdownPreview"
            "MarkdownPreviewStop"
            "MarkdownPreviewToggle"
          ];
        };
      };

      # Not lazy-loaded on `ft`: lz.n re-fires FileType to load it, which runs
      # the ftplugin's b:undo_ftplugin twice and raises E31 on every markdown
      # buffer. It only attaches to `file_types` anyway.
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
          file_types = markdownFileTypes;
        };
      };

      # Java
      # Not lazy-loaded on `ft` for the same reason as render-markdown (E216
      # from the java ftplugin's undo); its setup is empty, so loading it
      # eagerly costs nothing. The server itself starts via vim.lsp.enable.
      jdtls.enable = true;
    };

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
