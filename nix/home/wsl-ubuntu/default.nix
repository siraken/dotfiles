{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = import ../../lib/overlays.nix { inherit inputs; };
  };
  modules = [
    ../../modules/home/common.nix
    ./home.nix
    {
      home = {
        username = userProfile.username;
        homeDirectory = "/home/${userProfile.username}";
      };
    }
  ];
  extraSpecialArgs = { inherit inputs userProfile; };
}
