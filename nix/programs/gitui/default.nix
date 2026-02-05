{ pkgs, ... }:
let
  colors = import ../../colors/tokyonight.nix;
in
{
  programs.gitui = {
    enable = true;
  };
}
