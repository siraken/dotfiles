{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
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
        extraSpecialArgs = { inherit inputs userProfile; };
      };
    }
  ];
  specialArgs = { inherit inputs userProfile; };
}
