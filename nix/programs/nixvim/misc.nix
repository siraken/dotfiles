# Miscellaneous plugins
{ pkgs, ... }:
let
  better-escape-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "better-escape-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "max397574";
      repo = "better-escape.nvim";
      rev = "19a38aab94961016430905ebec30d272a01e9742";
      hash = "sha256-OmCZQN9qMSSEBmZaRR5QoJ+RRm13pnu+0uAUoz6X7oA=";
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
