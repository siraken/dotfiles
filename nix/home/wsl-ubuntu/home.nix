{ ... }:
{
  home.stateVersion = "26.05";

  imports = [
    ../profiles/full.nix
    # inputs.dotfiles-private.homeManagerModules.default
    # host-specific programs
    ../../programs/spotify-player
  ];
}
