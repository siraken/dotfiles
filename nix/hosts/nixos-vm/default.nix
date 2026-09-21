{
  inputs,
  userProfile,
  backupFileExtension,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile backupFileExtension; }) {
  homeModule = ./home.nix;
  system = "aarch64-linux";
  modules = [
    ./configuration.nix
  ];
}
