{ ... }:
{
  imports = [
    ../../modules/home/profile-full.nix
    ../../modules/home/profile-darwin.nix
    # host-specific programs
    ../../programs/fastfetch
    ../../programs/fish
    # ../../programs/spotify-player # disabled: nixpkgs linker crash (cctools-binutils-darwin)
    # ../../programs/vscode
  ];
}
