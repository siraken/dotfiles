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

    git-personas = {
      url = "github:siraken/git-personas.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    op-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
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
      nix-on-droid,
      nixos-wsl,
      op-shell-plugins,
      # dotfiles-private,
      ...
    }:
    let
      userProfile = {
        username = "siraken";
        name = "Kento Shirasawa";
        nameJa = "白澤 賢斗";
        nameKana = "しらさわ けんと";
        email = "shirasawa@novalumo.com";
        org = "novalumo";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlD3C6lBO9hb+JO/odNgS6D/jOqU4Bse4pvMd3VdZGL";
      };
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
        "aarch64-linux"
        "x86_64-linux"
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
            programs.stylua = {
              enable = true;
              excludes = [
                # Lua fragments for nixvim __raw (not valid standalone Lua)
                "nix/programs/vim/git/gitsigns-on-attach.lua"
                "nix/programs/vim/lang/rustaceanvim-on-attach.lua"
                "nix/programs/vim/lua/keymap-file-info.lua"
              ];
            };
            programs.shfmt.enable = true;
            programs.biome = {
              enable = true;
              excludes = [
                "**/lazy-lock.json"
                # Claude Code owns this file's format (tab-indented); let it manage it.
                "**/.claude/settings.json"
              ];
            };
            programs.yamlfmt.enable = true;
            programs.mdformat.enable = true;
            programs.fish_indent.enable = true;
            programs.taplo.enable = true;
          };

          pre-commit.settings.hooks = {
            treefmt.enable = true;
          };

          devShells.default = config.pre-commit.devShell;

          checks = {
            # Forces a full, pure evaluation of every configuration in this
            # flake. Producing the derivation paths is what does the work; the
            # string context is discarded so building this check never builds a
            # profile. It costs seconds and runs on every system, so a broken
            # module or a typo in any host fails CI even though the runner
            # cannot build the profiles themselves.
            eval-all = pkgs.writeText "eval-all-configurations" (
              nixpkgs.lib.concatMapStringsSep "\n" builtins.unsafeDiscardStringContext (
                [
                  self.darwinConfigurations.siraken-mbp.system.drvPath
                  self.darwinConfigurations.siraken-macmini.system.drvPath
                  self.nixosConfigurations.nixos-vm.config.system.build.toplevel.drvPath
                  self.nixosConfigurations.wsl-nixos.config.system.build.toplevel.drvPath
                ]
                ++ nixpkgs.lib.mapAttrsToList (_: home: home.activationPackage.drvPath) self.homeConfigurations
              )
            );

            # Real builds of the two small generic profiles for this system.
            # Unlike the full host closures below they fit on a GitHub-hosted
            # runner, so CI proves that `base` / `standard` actually build and
            # not only evaluate.
            home-base = self.homeConfigurations."${userProfile.username}@base-${system}".activationPackage;
            home-standard =
              self.homeConfigurations."${userProfile.username}@standard-${system}".activationPackage;
          }
          // nixpkgs.lib.optionalAttrs (system == "aarch64-darwin") {
            # Real system builds. A GitHub-hosted runner has 14 GB of disk and
            # one system closure is 12.4 GiB, so these only ever run locally
            # (`nix flake check` on the Mac); CI builds only the generic `base` /
            # `standard` home profiles above.
            siraken-mbp = self.darwinConfigurations.siraken-mbp.system;
            siraken-macmini = self.darwinConfigurations.siraken-macmini.system;
          };
        }
        // nixpkgs.lib.optionalAttrs (system == "aarch64-darwin") {
          apps =
            let
              darwinApp = mkApp pkgs;
              homeManager = "${home-manager.packages.${system}.home-manager}/bin/home-manager";
              # nix-darwin owns the OS layer and home-manager the user
              # environment; apply both, OS first.
              switchHost = host: ''
                set -e
                sudo darwin-rebuild switch --flake ${self}#${host}
                ${homeManager} switch -b ${backupFileExtension} --flake ${self}#${userProfile.username}@${host}
              '';
            in
            {
              mbp = darwinApp "mbp" (switchHost "siraken-mbp");
              macmini = darwinApp "macmini" (switchHost "siraken-macmini");
              gc = darwinApp "gc" ''
                nix store gc
              '';
            };
        };

      flake = {
        darwinConfigurations = {
          "siraken-mbp" = import ./nix/hosts/siraken-mbp {
            inherit inputs userProfile;
          };
          "siraken-macmini" = import ./nix/hosts/siraken-macmini {
            inherit inputs userProfile;
          };
        };

        nixosConfigurations = {
          "nixos-vm" = import ./nix/hosts/nixos-vm {
            inherit inputs userProfile;
          };
          "wsl-nixos" = import ./nix/hosts/wsl-nixos {
            inherit inputs userProfile;
          };
        };

        # nixOnDroidConfigurations = {
        #   "pixel10" = import ./nix/hosts/pixel10 {
        #     inherit inputs userProfile;
        #   };
        # };

        # Standalone home-manager: known hosts (`siraken@<host>`) and generic
        # profiles (`siraken@<profile>-<system>`). See nix/home/default.nix.
        homeConfigurations = import ./nix/home { inherit inputs userProfile; };
      };
    };
}
