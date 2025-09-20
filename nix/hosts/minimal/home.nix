{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  username = "siraken";
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    ../../programs/zoxide.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";

    file = import ../../modules/symlinks.nix {
      inherit config dotfilesPath;
    } // {

    };

    packages = [
      pkgs.eza
      pkgs.bat
      pkgs.neovim
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
      pkgs.jq
    ];
  };

  programs.home-manager.enable = true;
}
