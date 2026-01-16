{ pkgs, ... }:
let
  colors = import ../colors/tokyonight.nix;
  c = colors.fzfTransparent;
in
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    colors = {
      fg = c.fg;
      bg = c.bg;
      hl = c.hl;
      "fg+" = c.fgPlus;
      "bg+" = c.bgPlus;
      "hl+" = c.hlPlus;
      info = c.info;
      prompt = c.prompt;
      pointer = c.pointer;
      marker = c.marker;
      spinner = c.spinner;
      header = c.header;
      border = c.border;
    };
  };
}
