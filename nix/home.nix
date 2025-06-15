{ config, pkgs, ... }:
let
  username = "siraken";
in {
  imports = [
    # ./environment/system-packages.nix
    # ./programs/bash.nix
    # ./programs/zsh.nix
    # ./programs/fish.nix
    # ./programs/tmux.nix
    # ./programs/direnv.nix
    # ./programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
