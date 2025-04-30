{
  pkgs,
  lib,
  username,
  ...
}:
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11";
  };
}
