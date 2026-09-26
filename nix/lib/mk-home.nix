# Standalone home-manager builder.
#
# The counterpart to `mk-darwin-host.nix` / `mk-nixos-host.nix` for the user
# environment. A home configuration built here does not depend on nix-darwin or
# NixOS, so the same profile (`nix/home/profiles/*`) applies unchanged on
# macOS, NixOS, and any other Linux with Nix installed.
#
# Usage (from `nix/home/<name>/default.nix`):
#
#   { inputs, userProfile, ... }:
#   (import ../../lib/mk-home.nix { inherit inputs userProfile; }) {
#     system = "x86_64-linux";
#     homeModule = ./home.nix;
#   }
#
# `backupFileExtension` is not taken: standalone home-manager has no option for
# it, so it is passed on the command line (`home-manager switch -b hm-backup`).
{
  inputs,
  userProfile,
}:
{
  system,
  homeModule,
  extraSpecialArgs ? { },
}:
inputs.home-manager.lib.homeManagerConfiguration {
  # Same nixpkgs settings the nix-darwin / NixOS hosts apply globally
  # (`useGlobalPkgs`), so a profile evaluates identically either way.
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = import ./overlays.nix { inherit inputs; };
    config.allowUnfree = true;
  };

  modules = [
    homeModule
    # Wired in through `sharedModules` by the nix-darwin / NixOS builders.
    inputs.nixvim.homeModules.nixvim
    (
      { pkgs, ... }:
      {
        home = {
          username = userProfile.username;
          homeDirectory =
            if pkgs.stdenv.hostPlatform.isDarwin then
              "/Users/${userProfile.username}"
            else
              "/home/${userProfile.username}";
        };
      }
    )
  ];

  # `isWSL` is always passed: a default written in a module's argument list
  # (`isWSL ? false`) is ignored by the module system, so a module that reads it
  # fails on any host that does not supply it.
  extraSpecialArgs = {
    inherit inputs userProfile;
    isWSL = false;
  }
  // extraSpecialArgs;
}
