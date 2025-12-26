# Core dependencies and utilities
{ pkgs, ... }:
let
  snacks-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "snacks-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "snacks.nvim";
      rev = "fe7cfe9800a182274d0f868a74b7263b8c0c020b";
      hash = "sha256-vRedYg29QGPGW0hOX9qbRSIImh1d/SoDZHImDF2oqKM=";
    };
    doCheck = false;
  };
in
{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = { };
        ai = { n_lines = 500; };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
      snacks-nvim
    ];

    extraConfigLua = ''
      require("snacks").setup({
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        indent = { enabled = false },
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = true },
      })
    '';
  };
}
