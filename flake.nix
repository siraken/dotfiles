{
  description = "siraken's Nix configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
      whoami = {
        username = "siraken";
        fullName = "Kento Shirasawa";
      };

      darwinSystem = nix-darwin.lib.darwinSystem;
      nixosSystem = nixpkgs.lib.nixosSystem;

      # Function for home-manager configuration
      mkHomeConfiguration =
        {
          username,
          homeDirectory,
          pkgs,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [
            ./nix/hosts/wsl-ubuntu/home.nix
            {
              home = {
                username = username;
                homeDirectory = homeDirectory;
                stateVersion = "25.11";
              };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
    in
    {
      formatter = {
        "aarch64-darwin" = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
      };

      devShells = {
        "aarch64-darwin" = {
          default = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
            buildInputs = [
              nixpkgs.legacyPackages.aarch64-darwin.nixfmt
              nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt
            ];
          };
        };
        "x86_64-linux" = {
          default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
            buildInputs = [
              nixpkgs.legacyPackages.x86_64-linux.nixfmt
              nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt
            ];
          };
        };
      };

      darwinConfigurations = {
        "darwin" = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${whoami.username}" = {
                  name = "${whoami.username}";
                  home = "/Users/${whoami.username}";
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
            ./nix/hosts/darwin-min/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${whoami.username}" = {
                  name = "${whoami.username}";
                  home = "/Users/${whoami.username}";
                };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.siraken = import ./nix/hosts/darwin-min/home.nix;
            }
          ];
        };
      };

      nixosConfigurations = {
        "your-linux-machine-name" = nixosSystem {
          system = "x86_64-linux";
          username = whoami.username;
          modules = [
            ./nix/hosts/nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "wsl-ubuntu" = mkHomeConfiguration {
          username = whoami.username;
          homeDirectory = "/home/${whoami.username}";
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
