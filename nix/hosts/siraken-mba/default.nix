{
  inputs,
  userProfile,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile; }) {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./desktop.nix
    ./vm.nix
    inputs.nixos-hardware.nixosModules.apple-macbook-air-6
  ];
}
