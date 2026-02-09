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
    # modules
    ../../modules/aliases.nix
    ../../modules/nixpkgs.nix
    # programs
    ../../programs/zoxide
    ../../programs/git
    ../../programs/zsh
    ../../programs/tmux
    ../../programs/yazi
    ../../programs/starship
  ];

  dotfiles.aliases.enable = true;
  dotfiles.packages = {
    enable = true;
    extraPackages = with pkgs; [
      # minimal specific
      gcc
      libgcc
      xdg-utils
      nixfmt
    ];
  };

  home = {
    stateVersion = "25.11";

    file =
      import ../../modules/symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };
  };

  programs.home-manager.enable = true;
}
