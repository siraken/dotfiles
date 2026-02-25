{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = {
    inherit inputs userProfile;
    hostName = "siraken-macmini";
  };
  modules = [
    ../../modules/darwin/common.nix
    {
      homebrew = {
        brews = [
          "ansible"
          "cloudflared"
        ];
        casks = [
          "alt-tab"
          "appcleaner"
          "drivedx"
          "ghostty"
          "github"
          "google-chrome"
          "thebrowsercompany-dia"
          "visual-studio-code"
          "vivaldi"
          "raycast"
        ];
        masApps = { };
      };
    }
    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.default
      ];
    }
    inputs.home-manager.darwinModules.home-manager
    {
      users.users = {
        "${userProfile.username}" = {
          name = "${userProfile.username}";
          home = "/Users/${userProfile.username}";
        };
      };
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
}
