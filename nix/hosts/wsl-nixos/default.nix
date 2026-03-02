{
  inputs,
  userProfile,
  backupFileExtension,
}:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
  };
in
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    inputs.nixos-wsl.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.default
      ];
    }
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = backupFileExtension;
        users.${userProfile.username} = ./home.nix;
        sharedModules = [
          inputs.nixvim.homeModules.nixvim
        ];
        extraSpecialArgs = { inherit inputs userProfile pkgs-stable; };
      };
    }
  ];
  specialArgs = { inherit inputs userProfile; };
}
