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

      darwinSystem = nix-darwin.lib.darwinSystem;
      nixosSystem = nixpkgs.lib.nixosSystem;

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
        "darwin" = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${users.siraken.username}" = {
                  name = "${users.siraken.username}";
                  home = "/Users/${users.siraken.username}";
                };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.siraken = import ./nix/hosts/darwin/home.nix;
            }
          ];
        };

        "darwin-min" = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${users.siraken.username}" = {
                  name = "${users.siraken.username}";
                  home = "/Users/${users.siraken.username}";
                };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.siraken = import ./nix/hosts/darwin/home.nix;
            }
          ];
        };
      };

      nixosConfigurations = {
        "your-linux-machine-name" = nixosSystem {
          system = "x86_64-linux";
          username = users.siraken.username;
          modules = [
            ./nix/hosts/nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "wsl-ubuntu" = mkHomeConfiguration {
          username = users.siraken.username;
          homeDirectory = "/home/${users.siraken.username}";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
        "minimal" = mkHomeConfiguration {
          username = users.siraken.username;
          homeDirectory = "/home/${users.siraken.username}";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
