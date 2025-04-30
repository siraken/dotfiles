{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    completion = {
      enable = true;
    };
  };
}
