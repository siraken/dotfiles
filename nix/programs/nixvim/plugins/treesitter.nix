# Treesitter configuration
{ pkgs, ... }:
let
  ts-comments-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "ts-comments-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "ts-comments.nvim";
      rev = "5262536a69c0403ca5ab3b34eba0665d0526065e";
      hash = "sha256-HHLUVGr7QbOkj/m/wIjPt5tHjRPNdoMb/+0xMq7vQOw=";
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
