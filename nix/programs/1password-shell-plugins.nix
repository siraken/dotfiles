{ pkgs, ... }:
{
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      awscli2
      cachix
    ];
  };
}
