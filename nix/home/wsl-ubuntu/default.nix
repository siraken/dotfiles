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
    ../main.nix
    (
      { lib, ... }:
      {
        nixpkgs.config = {
          allowUnfree = true;
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "1password-cli"
            ];
        };
        home = {
          username = userProfile.username;
          homeDirectory = "/home/${userProfile.username}";
          stateVersion = "26.05";
        };
      }
    )
  ];
  extraSpecialArgs = {
    inherit inputs userProfile;
    isDarwin = false;
  };
}
