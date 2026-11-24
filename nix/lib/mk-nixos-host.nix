# NixOS host builder.
#
# The counterpart to `mk-darwin-host.nix`: holds the wiring shared by every
# NixOS host (binary caches, overlays, Nix settings, store optimisation, and
# GC). `./configuration.nix` and any platform module (e.g. NixOS-WSL) are
# passed in through `modules`.
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
    ../modules/nix-caches.nix
    ../modules/nixos/zsh.nix
    (
      { lib, ... }:
      {
        nixpkgs = {
          hostPlatform = system;
          config.allowUnfree = true;
          overlays = import ./overlays.nix { inherit inputs; };
        };

        nix = {
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            # NixOS already trusts root by default (`nixos/modules/config/nix.nix`).
            trusted-users = [ userProfile.username ];
          };

          # Hard-link identical files in the store once a week. Persistent, so a
          # run missed while asleep happens at the next boot.
          optimise = {
            automatic = true;
            dates = [ "weekly" ];
          };
        };

        # Keep at least the last three generations and everything from the last
        # week (system and every user's profiles, including home-manager),
        # collecting the rest weekly. `nix.gc` can only prune by age and would
        # drop all rollback generations after a week without a rebuild.
        programs.nh = {
          enable = true;
          clean = {
            enable = true;
            dates = "weekly";
            extraArgs = lib.mkDefault "--keep 3 --keep-since 7d";
          };
        };
      }
    )
  ]
  ++ modules;
}
