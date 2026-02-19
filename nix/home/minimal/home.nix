{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    ../../programs/zoxide
    ../../programs/git
    ../../programs/zsh
    ../../programs/tmux
    ../../programs/yazi
    ../../programs/starship
  ];

  home = {
    stateVersion = "26.05";
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    file =
      import ../../modules/symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      # minimal specific
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
      pkgs.nixfmt
    ];
  };

  programs.home-manager.enable = true;
}
