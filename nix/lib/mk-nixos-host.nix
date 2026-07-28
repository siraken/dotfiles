# NixOS host builder.
#
# The counterpart to `mk-darwin-host.nix`: holds the wiring that `nixos-vm` and
# `wsl-nixos` had duplicated (binary caches, nix-index, overlays, home-manager).
# `./configuration.nix` and any platform module (e.g. NixOS-WSL) are passed in
# through `modules`.
#
# Usage (from `nix/hosts/<host>/default.nix`):
#
#   { inputs, userProfile, backupFileExtension }:
#   (import ../../lib/mk-nixos-host.nix { inherit inputs userProfile backupFileExtension; }) {
#     homeModule = ./home.nix;
#     modules = [ ./configuration.nix inputs.nixos-wsl.nixosModules.default ];
#   }
{
  inputs,
  userProfile,
  backupFileExtension,
}:
{
  homeModule,
  system ? "x86_64-linux",
  modules ? [ ],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = { inherit inputs userProfile; };

  modules = [
    ../modules/nix-caches.nix
    inputs.nix-index-database.nixosModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    { nixpkgs.overlays = import ./overlays.nix { inherit inputs; }; }
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        inherit backupFileExtension;
        users.${userProfile.username} = homeModule;
        sharedModules = [
          inputs.nixvim.homeModules.nixvim
        ];
        extraSpecialArgs = { inherit inputs userProfile; };
      };
    }
  ]
  ++ modules;
}
