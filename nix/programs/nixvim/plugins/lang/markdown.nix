# Markdown support
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;
    };

    plugins.render-markdown = {
      enable = true;
      settings = {
        code = {
          sign = false;
          width = "block";
          right_pad = 1;
        };
        heading = {
          sign = false;
          icons = { };
        };
      };
    };

    keymaps = [
      { mode = "n"; key = "<leader>cp"; action = "<cmd>MarkdownPreviewToggle<cr>"; options.desc = "Markdown Preview"; }
    ];
  };
}
