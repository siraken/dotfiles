{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      (final: _prev: {
        llm-agents = inputs.llm-agents.packages.${final.stdenv.hostPlatform.system};
      })
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
