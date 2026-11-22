{ ... }:
{
  imports = [
    ../../home/profiles/full.nix
    ../../modules/home/nixos-host.nix
    # host-specific programs
    ../../programs/spotify-player
  ];

  home.stateVersion = "26.05";
}
