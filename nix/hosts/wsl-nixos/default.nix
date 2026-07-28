{
  inputs,
  userProfile,
  backupFileExtension,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile backupFileExtension; }) {
  homeModule = ./home.nix;
  modules = [
    ./configuration.nix
    inputs.nixos-wsl.nixosModules.default
  ];
}
