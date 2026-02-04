{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    layouts = { };
    settings = {
      theme = "tokyo-night-dark";
      show_startup_tips = false;
      show_release_notes = true;
    };
  };
}
