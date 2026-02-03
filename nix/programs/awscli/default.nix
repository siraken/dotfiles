{ pkgs, ... }:
{
  programs.awscli = {
    enable = true;
    settings = { };
  };
}
