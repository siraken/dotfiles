{ ... }:
{
  imports = [
    ../../modules/home/profile-full.nix
    # host-specific programs
    ../../programs/spotify-player
    # ../../programs/fish # disabled due to fisher hash mismatch
  ];

  home = {
    stateVersion = "26.05";

    # fish is not installed on this host (see above).
    shell.enableFishIntegration = false;
  };
}
