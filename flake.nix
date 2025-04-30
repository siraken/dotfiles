{
  description = "siraken's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
    }:
    let
      darwinUser = "siraken";
      darwinHost = "Kentos-MacBook-Pro";

      mkDarwinSystem =
        { hostname, username }:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.siraken = ./nix/darwin/home.nix;
            }
          ];
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Kentos-MacBook-Pro
      # $ darwin-rebuild switch --flake .#Kentos-MacBook-Pro
      darwinConfigurations = {
        ${darwinHost} = mkDarwinSystem {
          hostname = darwinHost;
          username = darwinUser;
        };
      };
    };
}
