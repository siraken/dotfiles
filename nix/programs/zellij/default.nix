{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    layouts = {
      editor = import ./layouts/editor.nix;
      quad = import ./layouts/quad.nix;
      hex = import ./layouts/hex.nix;
    };
    settings = {
      default_shell = "bash";
      theme = "tokyo-night";
      show_startup_tips = false;
      show_release_notes = true;
      mouse_mode = false;
      scrollback_editor = "${pkgs.neovim}/bin/nvim";
    };
  };
}
