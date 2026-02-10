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
      inputs.nixpkgs.follows = "nixpkgs";
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
      linuxSystem = "x86_64-linux";
      backupFileExtension = "hm-backup";

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
        "aarch64-darwin"
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
        // nixpkgs.lib.optionalAttrs (system == "aarch64-darwin") {
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
          "siraken-mbp" = import ./nix/hosts/siraken-mbp {
            inherit inputs user backupFileExtension;
          };
          "siraken-macmini" = import ./nix/hosts/siraken-macmini {
            inherit inputs user backupFileExtension;
          };
        };

        nixosConfigurations = {
          "nixos-vm" = import ./nix/hosts/nixos-vm {
            inherit inputs user backupFileExtension;
          };
        };

        # nixOnDroidConfigurations = {
        #   "pixel10" = import ./nix/hosts/pixel10 {
        #     inherit inputs user backupFileExtension;
        #   };
        # };

        homeConfigurations = {
          "wsl-ubuntu" = import ./nix/hosts/wsl-ubuntu {
            inherit inputs user backupFileExtension;
          };
        };
      };
    };
}
