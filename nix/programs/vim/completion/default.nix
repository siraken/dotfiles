{ ... }:
{
  programs.nixvim.plugins = {
    friendly-snippets.enable = true;

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [ "hide" ];
          "<C-y>" = [ "select_and_accept" ];
          "<C-p>" = [
            "select_prev"
            "fallback"
          ];
          "<C-n>" = [
            "select_next"
            "fallback"
          ];
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<Tab>" = [
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];
        };
        appearance.nerd_font_variant = "mono";
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          # Nixvim types this as a list, which cannot carry inherit_defaults.
          per_filetype.lua.__raw = "{ inherit_defaults = true, 'lazydev' }";
          providers.lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
            # Rank lazydev's require() / vim.* items above lua_ls's.
            score_offset = 100;
          };
        };
        completion = {
          accept.auto_brackets.enabled = true;
          menu.draw.treesitter = [ "lsp" ];
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
        };
        signature.enabled = true;
      };
    };
  };
}
