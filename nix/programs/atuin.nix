{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # daemon = {
    #   enable = true;
    # };
    # settings = { };
  };
}
