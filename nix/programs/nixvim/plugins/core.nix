# Core dependencies and utilities
{ pkgs, ... }:
# TODO: Re-enable when hash is updated
# let
#   snacks-nvim = pkgs.vimUtils.buildVimPlugin {
#     pname = "snacks-nvim";
#     version = "2024-12-26";
#     src = pkgs.fetchFromGitHub {
#       owner = "folke";
#       repo = "snacks.nvim";
#       rev = "bc0630e43be5699bb94dadc302c0d21615421d93";
#       hash = "sha256-Gw0Bp2YeoESiBLs3NPnqke3xwEjuiQDDU1CPofrhtig=";
#     };
#   };
# in
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
      # snacks-nvim  # TODO: Re-enable when hash is updated
    ];

    # TODO: Re-enable snacks.nvim setup when plugin is enabled
    # extraConfigLua = ''
    #   require("snacks").setup({
    #     bigfile = { enabled = true },
    #     dashboard = { enabled = false },
    #     indent = { enabled = false },
    #     input = { enabled = true },
    #     notifier = { enabled = true },
    #     quickfile = { enabled = true },
    #     scroll = { enabled = false },
    #     statuscolumn = { enabled = false },
    #     words = { enabled = true },
    #   })
    # '';
  };
}
