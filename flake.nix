{
  description = "siraken's dotfiles configuration";

  nixConfig = { };

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
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

    openclaw = {
      url = "github:openclaw/nix-openclaw";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    op-shell-plugins = {
      url = "github:1Password/shell-plugins";
    };

    # dotfiles-private = {
    #   url = "git+ssh://git@github.com/siraken/dotfiles-private";
    # };
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nix-darwin,
      nix-index-database,
      nixvim,
      home-manager,
      treefmt-nix,
      git-hooks,
      llm-agents,
      openclaw,
      nix-on-droid,
      op-shell-plugins,
      # dotfiles-private,
      ...
    }:
    let
      user = {
        username = "siraken";
        name = "Kento Shirasawa";
        email = "shirasawa@novalumo.com";
        org = "novalumo";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjyytl+QL/ikAdL+f/xIl4/QeT/Pic9I+r/+nW7lAIL";
      };
      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
      backupFileExtension = "hm-backup";

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
            nix-index-database.hmModules.nix-index
            openclaw.homeManagerModules.openclaw
            { programs.nix-index-database.comma.enable = true; }
            {
              home = {
                username = username;
                homeDirectory = homeDirectory;
                stateVersion = "25.11";
              };
            }
          ];
          extraSpecialArgs = { inherit inputs user; };
        };

      # Function for creating app entries
      mkApp = pkgs: name: script: {
        type = "app";
        program = toString (pkgs.writeShellScript name script);
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      systems = [
        darwinSystem
        linuxSystem
      ];

      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.stylua.enable = true;
            programs.shfmt.enable = true;
            programs.biome = {
              enable = true;
              excludes = [ "**/lazy-lock.json" ];
            };
            programs.yamlfmt.enable = true;
            programs.mdformat.enable = true;
            programs.fish_indent.enable = true;
          };

          pre-commit.settings.hooks = {
            treefmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            shellHook = config.pre-commit.installationScript;
            buildInputs = [
              pkgs.nixfmt
              pkgs.nixpkgs-fmt
            ];
          };
        }
        // nixpkgs.lib.optionalAttrs (system == darwinSystem) {
          apps =
            let
              darwinApp = mkApp pkgs;
            in
            {
              mbp = darwinApp "mbp" ''
                sudo darwin-rebuild switch --flake ${self}#siraken-mbp --impure
              '';
              macmini = darwinApp "macmini" ''
                sudo darwin-rebuild switch --flake ${self}#siraken-macmini --impure
              '';
              gc = darwinApp "gc" ''
                nix store gc
              '';
            };

          checks = {
            siraken-mbp = self.darwinConfigurations.siraken-mbp.system;
            siraken-macmini = self.darwinConfigurations.siraken-macmini.system;
          };
        };

      flake = {
        darwinConfigurations = {
          "siraken-mbp" = mkDarwinSystem {
            system = darwinSystem;
            specialArgs = {
              inherit inputs user;
              hostName = "siraken-mbp";
            };
            modules = [
              ./nix/hosts/darwin/configuration.nix
              nix-index-database.darwinModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
              {
                nixpkgs.overlays = [
                  llm-agents.overlays.default
                  openclaw.overlays.default
                ];
              }
              home-manager.darwinModules.home-manager
              {
                users.users = {
                  "${user.username}" = {
                    name = "${user.username}";
                    home = "/Users/${user.username}";
                  };
                };
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = backupFileExtension;
                  users.${user.username} = ./nix/hosts/darwin/home.nix;
                  sharedModules = [
                    nixvim.homeModules.nixvim
                    openclaw.homeManagerModules.openclaw
                  ];
                  extraSpecialArgs = { inherit inputs user; };
                };
              }
            ];
          };

          "siraken-macmini" = mkDarwinSystem {
            system = darwinSystem;
            specialArgs = {
              inherit inputs user;
              hostName = "siraken-macmini";
            };
            modules = [
              ./nix/hosts/darwin-min/configuration.nix
              nix-index-database.darwinModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
              {
                nixpkgs.overlays = [
                  llm-agents.overlays.default
                  openclaw.overlays.default
                ];
              }
              home-manager.darwinModules.home-manager
              {
                users.users = {
                  "${user.username}" = {
                    name = "${user.username}";
                    home = "/Users/${user.username}";
                  };
                };

                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = backupFileExtension;
                  users.${user.username} = ./nix/hosts/darwin-min/home.nix;
                  sharedModules = [
                    nixvim.homeModules.nixvim
                    openclaw.homeManagerModules.openclaw
                  ];
                  extraSpecialArgs = { inherit inputs user; };
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
              nix-index-database.nixosModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
              {
                nixpkgs.overlays = [
                  llm-agents.overlays.default
                  openclaw.overlays.default
                ];
              }
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = backupFileExtension;
                  users.${user.username} = ./nix/hosts/nixos-vm/home.nix;
                  sharedModules = [
                    nixvim.homeModules.nixvim
                    openclaw.homeManagerModules.openclaw
                  ];
                  extraSpecialArgs = { inherit inputs user; };
                };
              }
            ];
            specialArgs = { inherit inputs user; };
          };
        };

        # nixOnDroidConfigurations = {
        #   "pixel10" = mkNixOnDroidSystem {
        #     system = "aarch64-linux";
        #     modules = [
        #       ./nix/hosts/pixel10/configuration.nix
        #     ];
        #   };
        # };

        homeConfigurations = {
          "wsl-ubuntu" = mkHomeConfiguration {
            username = user.username;
            homeDirectory = "/home/${user.username}";
            pkgs = import nixpkgs {
              system = linuxSystem;
              overlays = [
                llm-agents.overlays.default
                openclaw.overlays.default
              ];
            };
          };
        };
      };
    };
}
