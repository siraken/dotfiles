# Miscellaneous plugins
{ pkgs, ... }:
let
  better-escape-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "better-escape-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "max397574";
      repo = "better-escape.nvim";
      rev = "7031f5fce9e1c950289f85029e74c0605d8cc6d4";
      hash = "sha256-Lx4mnSp/Xew1Y13dOBvJ1kPVzgZLnCCIBYZGoeY7DDI=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      calendar-vim
      vim-polyglot
      SchemaStore-nvim
      better-escape-nvim
    ];

    extraConfigLua = ''
      require("better_escape").setup({
        timeout = 200,
        default_mappings = false,
        mappings = {
          i = { j = { k = "<Esc>" } },
          c = { j = { k = "<Esc>" } },
          t = { j = { k = "<C-\\><C-n>" } },
          v = { j = { k = "<Esc>" } },
          s = { j = { k = "<Esc>" } },
        },
      })
    '';
  };
}
