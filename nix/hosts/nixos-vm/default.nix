{
  inputs,
  userProfile,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile; }) {
  system = "aarch64-linux";
  modules = [
    ./configuration.nix
  ];
}
