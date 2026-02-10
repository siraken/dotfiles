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
      inputs.openclaw.overlays.default
    ];
  };
  modules = [
    ../../modules/home/common.nix
    ./home.nix
    {
      home = {
        username = userProfile.username;
        homeDirectory = "/home/${userProfile.username}";
        stateVersion = "25.11";
      };
    }
  ];
  extraSpecialArgs = { inherit inputs userProfile; };
}
