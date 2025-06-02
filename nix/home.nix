{ config, pkgs, ... }:
{
  home = {
    username = "siraken";
    homeDirectory = "/Users/siraken";

    imports = [
      ./environment/system-packages.nix
      # ./programs/bash.nix
      ./programs/zsh.nix
      # ./programs/direnv.nix
      # ./programs/starship.nix
    ];

    programs = {
      fish = {
        enable = true;
        vendor = {
          completions.enable = true;
          config.enable = true;
          functions.enable = true;
        };
      };
    };

    stateVersion = "25.05";
  };
}
