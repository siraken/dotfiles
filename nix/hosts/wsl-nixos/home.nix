{ ... }:
{
  imports = [
    ../../modules/home/profile-full.nix
    # host-specific programs
    ../../programs/spotify-player
    # ../../programs/fish # disabled due to fisher hash mismatch
  ];

  # fish is not installed on this host (see above).
  home.shell.enableFishIntegration = false;
}
