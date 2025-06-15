{ config, pkgs, ... }:
let
  username = "siraken";
in {
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

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
