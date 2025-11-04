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
    inputs.op-shell-plugins.hmModules.default
    # ../../environment/system-packages.nix
    ../../programs/1password-shell-plugins.nix
    # ../../programs/bash.nix
    ../../programs/zoxide.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    # ../../programs/fish.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/direnv.nix
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

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];
  };

  programs.home-manager.enable = true;
}
