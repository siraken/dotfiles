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
  systems ? [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ],
}:
let
  inherit (inputs.nixpkgs) lib;
  overlays = import ./overlays.nix { inherit inputs; };
  mkPkgs =
    system:
    import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  # Memoize nixpkgs per system across every configuration built from one
  # factory instance (`nix/home/default.nix` defines 15 across 3 systems).
  # Attrset entries are lazy, so single-system callers only evaluate the
  # system they request.
  pkgsBySystem = lib.genAttrs systems mkPkgs;
in
{
  system,
  homeModule,
  extraSpecialArgs ? { },
}:
let
  # Same nixpkgs settings the nix-darwin / NixOS hosts apply globally
  # (`useGlobalPkgs`), so a profile evaluates identically either way.
  pkgs = pkgsBySystem.${system} or (mkPkgs system);
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    homeModule
    # Wired in through `sharedModules` by the nix-darwin / NixOS builders.
    inputs.nixvim.homeModules.nixvim
    {
      # `homeManagerConfiguration` loads `misc/nixpkgs.nix`, which re-imports
      # `nixpkgs` from `pkgs.path` and binds `_module.args.pkgs` at default
      # priority (100), discarding the memoized `pkgs` passed above. Pinning
      # `_module.args.pkgs` here mirrors `useGlobalPkgs` so all configurations
      # sharing a system actually reuse one evaluated `nixpkgs` instance.
      _module.args.pkgs = lib.mkForce pkgs;

      home = {
        username = userProfile.username;
        homeDirectory =
          if pkgs.stdenv.hostPlatform.isDarwin then
            "/Users/${userProfile.username}"
          else
            "/home/${userProfile.username}";
      };
    }
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
