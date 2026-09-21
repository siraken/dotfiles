{
  inputs,
  userProfile,
  backupFileExtension,
}:
(import ../../lib/mk-nixos-host.nix { inherit inputs userProfile backupFileExtension; }) {
  homeModule = ./home.nix;
  system = "x86_64-linux";
  isWSL = true;
  modules = [
    ./configuration.nix
    inputs.nixos-wsl.nixosModules.default
  ];
}
