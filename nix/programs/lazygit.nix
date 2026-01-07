{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # settings = {
    #   gui = {

    #   };
    # };
  };
}
