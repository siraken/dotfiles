{ config, pkgs, ... }:
let
  username = "siraken";
in {
  home = {
    stateVersion = "25.05";
  };

  # imports = [
  #   ./environment/system-packages.nix
  #   # ./programs/bash.nix
  #   ./programs/zsh.nix
  #   # ./programs/fish.nix
  #   # ./programs/direnv.nix
  #   # ./programs/starship.nix
  # ];
}
