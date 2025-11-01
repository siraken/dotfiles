{ pkgs, ... }:
{
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
      awscli2
      cachix
    ];
  };
}
