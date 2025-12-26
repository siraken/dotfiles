# Treesitter configuration
{ pkgs, ... }:
let
  ts-comments-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "ts-comments-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "ts-comments.nvim";
      rev = "123a9fb12e7229342f807ec9e6de478b1102b041";
      hash = "sha256-ORK3XpHANaqvp1bfMG2GJmAiaOsLoGW82ebL/FJtKaA=";
    };
  };
in
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        auto_install = false; # Nix handles grammar installation
        ensure_installed = [
          "bash"
          "c"
          "css"
          "dockerfile"
          "go"
          "gomod"
          "gosum"
          "gowork"
          "html"
          "java"
          "javascript"
          "jsdoc"
          "json"
          "jsonc"
          "lua"
          "luadoc"
          "luap"
          "markdown"
          "markdown_inline"
          "nix"
          "python"
          "query"
          "regex"
          "ruby"
          "rust"
          "toml"
          "tsx"
          "typescript"
          "vim"
          "vimdoc"
          "yaml"
        ];
      };
    };

    plugins.treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
          };
        };
        move = {
          enable = true;
          goto_next_start = {
            "]f" = "@function.outer";
            "]c" = "@class.outer";
          };
          goto_next_end = {
            "]F" = "@function.outer";
            "]C" = "@class.outer";
          };
          goto_previous_start = {
            "[f" = "@function.outer";
            "[c" = "@class.outer";
          };
          goto_previous_end = {
            "[F" = "@function.outer";
            "[C" = "@class.outer";
          };
        };
      };
    };

    plugins.ts-autotag.enable = true;

    extraPlugins = [ ts-comments-nvim ];

    extraConfigLua = ''
      require("ts-comments").setup({})
    '';
  };
}
