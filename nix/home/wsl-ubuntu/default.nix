{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.llm-agents.overlays.default
    ];
  };
  modules = [
    ../../modules/home/common.nix
    ./home.nix
    {
      home = {
        username = userProfile.username;
        homeDirectory = "/home/${userProfile.username}";
        stateVersion = "26.05";
      };
    }
  ];
  extraSpecialArgs = { inherit inputs userProfile; };
}
