{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    layouts = { };
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
