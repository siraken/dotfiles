{ ... }:
{
  imports = [
    ../../home/profiles/full.nix
    ../../home/profiles/darwin.nix
    # host-specific programs
    ../../programs/fish
    ../../programs/spotify-player
    # ../../programs/vscode
  ];

  home.stateVersion = "26.05";
}
