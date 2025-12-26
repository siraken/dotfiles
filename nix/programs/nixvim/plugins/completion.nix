# Completion configuration (blink.cmp, copilot, snippets)
{ pkgs, ... }:
let
  blink-copilot = pkgs.vimUtils.buildVimPlugin {
    pname = "blink-copilot";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "fang2hou";
      repo = "blink-copilot";
      rev = "7ad8209b2f880a2840c94cdcd80ab4dc511d4f39";
      hash = "sha256-8Md8NKqAGLRiOdcTHzDKBRaCvKJe7f0D+w1aP5A/hxA=";
    };
  };
in
{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
          "<C-e>" = [ "hide" ];
          "<C-y>" = [ "select_and_accept" ];
          "<C-p>" = [ "select_prev" "fallback" ];
          "<C-n>" = [ "select_next" "fallback" ];
          "<C-b>" = [ "scroll_documentation_up" "fallback" ];
          "<C-f>" = [ "scroll_documentation_down" "fallback" ];
          "<Tab>" = [ "snippet_forward" "fallback" ];
          "<S-Tab>" = [ "snippet_backward" "fallback" ];
        };
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };
        sources = {
          default = [ "lsp" "path" "snippets" "buffer" "copilot" ];
          providers = {
            copilot = {
              name = "copilot";
              module = "blink-copilot";
              score_offset = 100;
              async = true;
            };
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

    plugins.copilot-lua = {
      enable = true;
      settings = {
        suggestion.enabled = false;
        panel.enabled = false;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      blink-copilot
    ];
  };
}
