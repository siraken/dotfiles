{
  pkgs,
  lib,
  ...
}:
{
  home = {
    username = "siraken";
    homeDirectory = "/Users/siraken";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
