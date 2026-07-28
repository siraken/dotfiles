# nix-darwin host builder.
#
# Everything that used to be duplicated in each `nix/hosts/*/default.nix`
# (nix-index, overlays, home-manager wiring, the user record) lives here. A host
# only declares its `hostName`, its home profile, and its own modules — homebrew
# lists, host-local services, and so on.
#
# Usage (from `nix/hosts/<host>/default.nix`):
#
#   { inputs, userProfile, backupFileExtension }:
#   (import ../../lib/mk-darwin-host.nix { inherit inputs userProfile backupFileExtension; }) {
#     hostName = "siraken-mbp";
#     homeModule = ./home.nix;
#     modules = [ { homebrew.casks = [ ... ]; } ];
#   }
{
  inputs,
  userProfile,
  backupFileExtension,
}:
{
  hostName,
  homeModule,
  system ? "aarch64-darwin",
  modules ? [ ],
}:
inputs.nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit inputs userProfile hostName;
  };

  modules = [
    ../modules/darwin/common.nix
    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    { nixpkgs.overlays = import ./overlays.nix { inherit inputs; }; }
    inputs.home-manager.darwinModules.home-manager
    {
      users.users.${userProfile.username} = {
        name = userProfile.username;
        home = "/Users/${userProfile.username}";
      };

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
