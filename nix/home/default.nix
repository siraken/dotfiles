# Every standalone home-manager configuration in this flake.
#
# - `siraken@<host>`: a known host. The name matches `$USER@$(hostname)`, so
#   on that host `home-manager switch --flake .` picks it without a name.
# - `siraken@<profile>-<system>`: a generic `base` / `standard` / `full`
#   profile for a host that has no entry of its own, e.g. a production server:
#     nix run home-manager/master -- switch \
#       --flake github:siraken/dotfiles#siraken@base-x86_64-linux
#
# The user is always `siraken`; only the host varies.
{
  inputs,
  userProfile,
}:
let
  inherit (inputs.nixpkgs) lib;
  mkHome = import ../lib/mk-home.nix { inherit inputs userProfile; };

  hosts = {
    siraken-mbp = {
      system = "aarch64-darwin";
      homeModule = ../hosts/siraken-mbp/home.nix;
    };
    siraken-macmini = {
      system = "aarch64-darwin";
      homeModule = ../hosts/siraken-macmini/home.nix;
    };
    wsl-nixos = {
      system = "x86_64-linux";
      homeModule = ../hosts/wsl-nixos/home.nix;
      isWSL = true;
    };
    nixos-vm = {
      system = "aarch64-linux";
      homeModule = ../hosts/nixos-vm/home.nix;
    };
    wsl-ubuntu = {
      system = "x86_64-linux";
      homeModule = ./wsl-ubuntu/home.nix;
      isWSL = true;
    };
  };

  profiles = [
    "base"
    "standard"
    "full"
  ];
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ];

  # A generic profile knows nothing about the host, so on Linux it assumes a
  # non-NixOS distribution: Nix is not managed by the OS, hence the user-level
  # caches and `targets.genericLinux`.
  genericModule = profile: system: {
    imports = [
      (./profiles + "/${profile}.nix")
    ]
    ++ lib.optionals (lib.hasSuffix "-linux" system) [
      ../modules/home/nix-caches.nix
      { targets.genericLinux.enable = true; }
    ];
    home.stateVersion = "26.05";
  };
in
lib.mapAttrs' (
  host: cfg:
  lib.nameValuePair "${userProfile.username}@${host}" (mkHome {
    inherit (cfg) system homeModule;
    extraSpecialArgs.isWSL = cfg.isWSL or false;
  })
) hosts
// lib.listToAttrs (
  lib.concatMap (
    profile:
    map (
      system:
      lib.nameValuePair "${userProfile.username}@${profile}-${system}" (mkHome {
        inherit system;
        homeModule = genericModule profile system;
      })
    ) systems
  ) profiles
)
