{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      # Line numbers
      number = true;
      relativenumber = true;

      # Indentation
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # Appearance
      background = "dark";

      # Undo
      undofile = false;
    };
  };
}
