{ ... }:
{
  home.stateVersion = "26.05";

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
