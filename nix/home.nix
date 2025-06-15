{ config, pkgs, ... }:
{
  home = {
    username = "siraken";
    homeDirectory = "/Users/siraken";

    imports = [
      ./environment/system-packages.nix
      # ./programs/bash.nix
      ./programs/zsh.nix
      # ./programs/fish.nix
      # ./programs/direnv.nix
      # ./programs/starship.nix
    ];

    stateVersion = "25.05";
  };
}
