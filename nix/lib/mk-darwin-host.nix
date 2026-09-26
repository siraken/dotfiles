# nix-darwin host builder.
#
# Everything that used to be duplicated in each `nix/hosts/*/default.nix`
# (overlays, the user record) lives here. A host only declares its `hostName`
# and its own modules — homebrew lists, host-local services, and so on.
#
# nix-darwin owns the OS layer only. The user environment is standalone
# home-manager (`homeConfigurations."siraken@<host>"`, see nix/home/default.nix),
# applied separately with `home-manager switch`.
#
# Usage (from `nix/hosts/<host>/default.nix`):
#
#   { inputs, userProfile }:
#   (import ../../lib/mk-darwin-host.nix { inherit inputs userProfile; }) {
#     hostName = "siraken-mbp";
#     modules = [ { homebrew.casks = [ ... ]; } ];
#   }
{
  inputs,
  userProfile,
}:
{
  hostName,
  system ? "aarch64-darwin",
  modules ? [ ],
}:
inputs.nix-darwin.lib.darwinSystem {
  inherit system;

  specialArgs = {
    inherit inputs userProfile hostName;
  };

  modules = [
    ../modules/darwin/base.nix
    { nixpkgs.overlays = import ./overlays.nix { inherit inputs; }; }
    {
      users.users.${userProfile.username} = {
        name = userProfile.username;
        home = "/Users/${userProfile.username}";
      };
    }
  ]
  ++ modules;
}
