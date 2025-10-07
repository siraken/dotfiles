{ pkgs, ... }:
{
  programs.bash = {
    enable = false;
    completion = {
      enable = true;
    };
  };
}
