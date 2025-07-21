{
  description = "siraken's Nix configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    };
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-on-droid,
      ...
    }:
    let
      users = {
        siraken = {
          username = "siraken";
          fullName = "Kento Shirasawa";
        };
      };

      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        { system, username }:
        nix-darwin.lib.darwinSystem {
          system = system;
          modules = [
            ./nix/hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${username}" = {
                  name = "${username}";
                  home = "/Users/${username}";
                };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.siraken = import ./nix/hosts/darwin/home.nix;
            }
          ];
        };

      # Function for NixOS system configuration
      mkNixOSConfiguration =
        { system, username }: nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./nix/hosts/nixos/configuration.nix
          ];
        };

      # Function for home-manager configuration
      mkHomeConfiguration =
        { username, homeDirectory, pkgs }: home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            ./nix/hosts/wsl-ubuntu/home.nix
            {
              home = {
                username = username;
                homeDirectory = homeDirectory;
                stateVersion = "25.05";
              };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
    in {
      darwinConfigurations = {
        "darwin" = mkDarwinConfiguration {
          system = "aarch64-darwin";
          username = users.siraken.username;
        };
      };

      nixosConfigurations = {
        "your-linux-machine-name" = mkNixOSConfiguration {
          system = "x86_64-linux";
          username = users.siraken.username;
        };
      };

      homeConfigurations = {
        "wsl-ubuntu" = mkHomeConfiguration {
          username = users.siraken.username;
          homeDirectory = "/home/${users.siraken.username}";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
