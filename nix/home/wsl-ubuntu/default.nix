{
  inputs,
  userProfile,
  ...
}:
(import ../../lib/mk-home.nix { inherit inputs userProfile; }) {
  system = "x86_64-linux";
  homeModule = ./home.nix;
  extraSpecialArgs.isWSL = true;
}
