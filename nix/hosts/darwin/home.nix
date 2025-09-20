{ config, pkgs, ... }:
let
  username = "siraken";
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    # ../../environment/system-packages.nix
    # ../../programs/bash.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    ../../programs/zoxide.nix
    # ../../programs/fish.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/direnv.nix
    ../../programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";
    # preferXdgDirectories = true; # to be enabled
    # sessionVariables = import ../../modules/variable.nix;
    # sessionPath = import ../../modules/path.nix;

    file = import ../../modules/dotfiles.nix {
      inherit config dotfilesPath;
    } // {

    };
  };

  programs.home-manager.enable = true;
}
