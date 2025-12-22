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
    ../../programs/zoxide.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/starship.nix
  ];

  home = {
    stateVersion = "25.11";

    file =
      import ../../modules/symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };

    packages = import ../../packages/nixpkgs.nix { inherit pkgs; } ++ [
      # minimal specific
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
      pkgs.neovim
      pkgs.nixfmt-rfc-style
    ];
  };

  programs.home-manager.enable = true;
}
