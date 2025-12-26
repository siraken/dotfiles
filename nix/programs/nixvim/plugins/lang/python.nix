# Python development
{ pkgs, ... }:
let
  venv-selector-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "venv-selector-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "linux-cultist";
      repo = "venv-selector.nvim";
      rev = "d2326e7433fdeb10f7d0d1237c18b91b353f9f8b";
      hash = "sha256-9fVH/EBbssmsUnZNxhxJC6d3sDImIqKtq5nFl/T8L7o=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ venv-selector-nvim ];

    extraConfigLua = ''
      require("venv-selector").setup({})
    '';

    keymaps = [
      { mode = "n"; key = "<leader>cv"; action = "<cmd>VenvSelect<cr>"; options.desc = "Select VirtualEnv"; }
    ];
  };
}
