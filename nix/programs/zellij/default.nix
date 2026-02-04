{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    layouts = { };
    settings = {
      theme = "tokyo-night";
    };
  };
}
