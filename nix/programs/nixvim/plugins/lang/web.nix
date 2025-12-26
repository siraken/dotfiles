# Web development (templates, tailwind)
{ pkgs, ... }:
# TODO: Re-enable when hash is updated
# let
#   vim-slim = pkgs.vimUtils.buildVimPlugin {
#     pname = "vim-slim";
#     version = "2024-12-26";
#     src = pkgs.fetchFromGitHub {
#       owner = "slim-template";
#       repo = "vim-slim";
#       rev = "a0a57f75f20a03d5fa798484743e98f4af623926";
#       hash = "sha256-mPv0tiggGExEZNshDlHtT4ipv/5Q0ahkcVw4irJ8l3o=";
#     };
#   };
#   tailwindcss-colorizer-cmp = pkgs.vimUtils.buildVimPlugin {
#     pname = "tailwindcss-colorizer-cmp-nvim";
#     version = "2024-12-26";
#     src = pkgs.fetchFromGitHub {
#       owner = "roobert";
#       repo = "tailwindcss-colorizer-cmp.nvim";
#       rev = "3d3cd95e4a4135c250faf83dd5ed61b8e5502b86";
#       hash = "sha256-PIkfJzLt001TojAnE/rdRhgVEwSvCvUJm/vNPLSWjpY=";
#     };
#   };
# in
{
  programs.nixvim = {
    # TODO: Re-enable vim-slim and tailwindcss-colorizer-cmp when hash is updated
    # extraPlugins = [
    #   vim-slim
    #   tailwindcss-colorizer-cmp
    # ];
  };
}
