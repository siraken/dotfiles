{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
    enableBashIntegration = true;
    # daemon = {
    #   enable = true;
    # };
    # settings = { };
  };
}
