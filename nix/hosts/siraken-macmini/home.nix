{ ... }:
{
  imports = [
    ../../modules/home/profile-full.nix
    ../../modules/home/profile-darwin.nix
    # host-specific programs
    ../../programs/fish
    ../../programs/spotify-player
    # ../../programs/vscode
  ];
}
