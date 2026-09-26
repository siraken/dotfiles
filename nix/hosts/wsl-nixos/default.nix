{
  inputs,
  userProfile,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile; }) {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    inputs.nixos-wsl.nixosModules.default
  ];
}
