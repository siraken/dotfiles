# Web development (templates, tailwind)
{ pkgs, ... }:
let
  vim-slim = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-slim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "slim-template";
      repo = "vim-slim";
      rev = "df26386b46b455f0c6c0c0c3f2d218014e7b82d1";
      hash = "sha256-CSffvQZ0V/PNxvVMPotNj4vTXbSgFx8V11+wePVJxZ0=";
    };
  };
  tailwindcss-colorizer-cmp = pkgs.vimUtils.buildVimPlugin {
    pname = "tailwindcss-colorizer-cmp-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "roobert";
      repo = "tailwindcss-colorizer-cmp.nvim";
      rev = "3d3cd95e4a4135c250faf83dd5ed61b8e5502b86";
      hash = "sha256-PIkfJzLt001TojAnE/rdRhgVEwSvCvUJm/vNPLSWjpY=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      vim-slim
      tailwindcss-colorizer-cmp
    ];
  };
}
