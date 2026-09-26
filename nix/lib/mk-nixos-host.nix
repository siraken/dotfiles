# NixOS host builder.
#
# The counterpart to `mk-darwin-host.nix`: holds the wiring that `nixos-vm` and
# `wsl-nixos` had duplicated (binary caches, overlays). `./configuration.nix`
# and any platform module (e.g. NixOS-WSL) are passed in through `modules`.
#
# NixOS owns the OS layer only. The user environment is standalone
# home-manager (`homeConfigurations."siraken@<host>"`, see nix/home/default.nix),
# applied separately with `home-manager switch`.
#
# Usage (from `nix/hosts/<host>/default.nix`):
#
#   { inputs, userProfile }:
#   (import ../../lib/mk-nixos-host.nix { inherit inputs userProfile; }) {
#     system = "x86_64-linux";
#     modules = [ ./configuration.nix inputs.nixos-wsl.nixosModules.default ];
#   }
{
  inputs,
  userProfile,
}:
{
  system,
  modules ? [ ],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = { inherit inputs userProfile; };

  modules = [
    { nixpkgs.hostPlatform = system; }
    ../modules/nix-caches.nix
    { nixpkgs.overlays = import ./overlays.nix { inherit inputs; }; }
  ]
  ++ modules;
}
