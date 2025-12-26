# Rust development
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.rustaceanvim = {
      enable = true;
      settings = {
        server = {
          on_attach.__raw = ''
            function(_, bufnr)
              vim.keymap.set("n", "<leader>cR", function()
                vim.cmd.RustLsp("codeAction")
              end, { desc = "Rust Code Action", buffer = bufnr })
              vim.keymap.set("n", "<leader>dr", function()
                vim.cmd.RustLsp("debuggables")
              end, { desc = "Rust Debuggables", buffer = bufnr })
            end
          '';
          default_settings = {
            rust-analyzer = {
              cargo = {
                allFeatures = true;
                loadOutDirsFromCheck = true;
                buildScripts.enable = true;
              };
              checkOnSave = true;
              procMacro = {
                enable = true;
                ignored = {
                  async-trait = [ "async_trait" ];
                  napi-derive = [ "napi" ];
                  async-recursion = [ "async_recursion" ];
                };
              };
            };
          };
        };
      };
    };

    plugins.crates = {
      enable = true;
      settings = {
        completion.crates.enabled = true;
      };
    };
  };
}
