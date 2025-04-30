{ pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    settings = null;
  };
}
