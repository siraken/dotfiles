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
    # ../../environment/system-packages.nix
    # ../../programs/bash.nix
    ../../programs/zoxide.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    # ../../programs/fish.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/direnv.nix
    ../../programs/starship.nix
    inputs._1password-shell-plugins.hmModules.default
  ];

  home = {
    stateVersion = "25.05";

    file = import ../../modules/dotfiles.nix {
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

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "1password-cli"
      ];
  };

  programs.home-manager.enable = true;
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
      awscli2
      cachix
    ];
  };
}
