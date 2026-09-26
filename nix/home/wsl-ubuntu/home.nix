{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.stateVersion = "26.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "1password-cli"
        ];
    };
  };

  imports = [
    ../profiles/full.nix
    ../../modules/home/nix-caches.nix
    # inputs.dotfiles-private.homeManagerModules.default
    # host-specific programs
    ../../programs/fish
    ../../programs/spotify-player
    # ../../programs/difftastic
  ];
}
