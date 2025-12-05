{
  description = "siraken's Nix configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    op-shell-plugins = {
      url = "github:1Password/shell-plugins";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      droid,
      op-shell-plugins,
      ...
    }:
    let
      whoami = {
        username = "siraken";
        fullName = "Kento Shirasawa";
      };

      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";

      mkDarwinSystem = nix-darwin.lib.darwinSystem;
      mkNixosSystem = nixpkgs.lib.nixosSystem;

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

      # Function for creating app entries
      mkApp = system: name: script: {
        type = "app";
        program = toString (nixpkgs.legacyPackages.${system}.writeShellScript name script);
      };
      darwinApp = mkApp darwinSystem;
    in
    {
      formatter = {
        ${darwinSystem} = nixpkgs.legacyPackages.${darwinSystem}.nixfmt-tree;
      };

      devShells = {
        ${darwinSystem} = {
          default = nixpkgs.legacyPackages.${darwinSystem}.mkShell {
            buildInputs = [
              nixpkgs.legacyPackages.${darwinSystem}.nixfmt
              nixpkgs.legacyPackages.${darwinSystem}.nixpkgs-fmt
            ];
          };
        };
        ${linuxSystem} = {
          default = nixpkgs.legacyPackages.${linuxSystem}.mkShell {
            buildInputs = [
              nixpkgs.legacyPackages.${linuxSystem}.nixfmt
              nixpkgs.legacyPackages.${linuxSystem}.nixpkgs-fmt
            ];
          };
        };
      };

      darwinConfigurations = {
        "darwin" = mkDarwinSystem {
          system = darwinSystem;
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
              home-manager.users.siraken = ./nix/hosts/darwin/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        "darwin-min" = mkDarwinSystem {
          system = darwinSystem;
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
              home-manager.users.siraken = ./nix/hosts/darwin-min/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };

      nixosConfigurations = {
        "your-linux-machine-name" = mkNixosSystem {
          system = linuxSystem;
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
          pkgs = nixpkgs.legacyPackages.${linuxSystem};
        };
      };

      apps = {
        ${darwinSystem} = {
          setup = darwinApp "setup" ''
            sudo darwin-rebuild switch --flake ${self}#darwin --impure
          '';
          setup-min = darwinApp "setup-min" ''
            sudo darwin-rebuild switch --flake ${self}#darwin-min --impure
          '';
          build = darwinApp "build" ''
            darwin-rebuild build --flake ${self}#darwin --impure
          '';
          gc = darwinApp "gc" ''
            nix store gc
          '';
        };
      };
    };
}
