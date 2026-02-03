{
  description = "siraken's dotfiles configuration";

  nixConfig = { };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    nix-on-droid = {
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
      nix-darwin,
      nix-index-database,
      nixvim,
      home-manager,
      treefmt-nix,
      llm-agents,
      nix-on-droid,
      op-shell-plugins,
      ...
    }:
    let
      username = "siraken";

      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";

      mkDarwinSystem = nix-darwin.lib.darwinSystem;
      mkNixosSystem = nixpkgs.lib.nixosSystem;
      mkNixOnDroidSystem = nix-on-droid.lib.nixOnDroidConfiguration;

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
            nix-index-database.darwinModules.nix-index
            home-manager.darwinModules.home-manager
            {
              users.users = {
                "${username}" = {
                  name = "${username}";
                  home = "/Users/${username}";
                };
              };
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                users.siraken = ./nix/hosts/darwin/home.nix;
                sharedModules = [ nixvim.homeModules.nixvim ];
                extraSpecialArgs = { inherit inputs; };
              };
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
                "${username}" = {
                  name = "${username}";
                  home = "/Users/${username}";
                };
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                users.siraken = ./nix/hosts/darwin-min/home.nix;
                sharedModules = [ nixvim.homeModules.nixvim ];
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        "nixos-vm" = mkNixosSystem {
          system = linuxSystem;
          modules = [
            ./nix/hosts/nixos-vm/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-backup";
                users.${username} = ./nix/hosts/nixos-vm/home.nix;
                sharedModules = [ nixvim.homeModules.nixvim ];
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      nixOnDroidConfigurations = {
        # "nixondroid-device" = mkNixOnDroidSystem {
        #   system = "aarch64-linux";
        #   modules = [
        #     ./nix/hosts/nixondroid/configuration.nix
        #   ];
        # };
      };

      homeConfigurations = {
        "wsl-ubuntu" = mkHomeConfiguration {
          username = username;
          homeDirectory = "/home/${username}";
          pkgs = nixpkgs.legacyPackages.${linuxSystem};
        };
      };

      checks = {
        ${darwinSystem} = {
          darwin = self.darwinConfigurations.darwin.system;
          darwin-min = self.darwinConfigurations.darwin-min.system;
        };
      };

      apps = {
        ${darwinSystem} = {
          sw = darwinApp "sw" ''
            sudo darwin-rebuild switch --flake ${self}#darwin --impure
          '';
          sw-min = darwinApp "sw-min" ''
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
