{
  inputs,
  user,
  backupFileExtension,
}:
inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = {
    inherit inputs user;
    hostName = "siraken-macmini";
  };
  modules = [
    ./configuration.nix
    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.default
        inputs.openclaw.overlays.default
      ];
    }
    inputs.home-manager.darwinModules.home-manager
    {
      users.users = {
        "${user.username}" = {
          name = "${user.username}";
          home = "/Users/${user.username}";
        };
      };
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = backupFileExtension;
        users.${user.username} = ./home.nix;
        sharedModules = [
          inputs.nixvim.homeModules.nixvim
          inputs.openclaw.homeManagerModules.openclaw
        ];
        extraSpecialArgs = { inherit inputs user; };
      };
    }
  ];
}
