{
  description = "siraken's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    }:
    {
      # macOS (darwin) configuration
      darwinConfigurations = {
        "mbp" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix/darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
              users.users.siraken = {
                home = {
                  username = "siraken";
                  homeDirectory = "/Users/siraken";
                  stateVersion = "25.05";
                };
              };
            }
          ];
        };
      };

      # Linux configuration
      # TODO: Add NixOS modules for your Linux machine
      nixosConfigurations = {
        "your-linux-machine-name" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, ... }:
              {
                environment.systemPackages = with pkgs; [
                  # uv
                  # ===== from `apk` =====
                  # bash
                  # git
                  # go
                  # openssh
                  # openssl
                  # gh
                  # tmux
                  # sudo
                  # vim
                  # neovim
                  # emacs
                  # eza
                  # neofetch
                  # docker
                  # nginx
                  # php81
                  # ===== from `apt` =====
                  # git
                  # curl
                  # wget
                  # libfuse2 -> not found
                  # tree
                  # neovim
                  # bat
                  # neofetch
                  # luajit
                  # eza
                  # # hhvm -> not found
                  # # powershell
                  # ===== from `pkg` =====
                  # bat
                  # eza
                  # gh
                  # git
                  # go
                  # neofetch
                  # neovim
                  # nodejs-lts -> not found
                  # tmux
                  # tree
                  # vim
                  # wget
                  # yarn
                  # openssh
                  # ===== from `snap` =====
                  # spt -> not found
                  # ===== from `pacman` =====
                  # base-devel -> not found
                  # libyaml
                  # curl
                  # wget
                  # git
                  # sudo
                  # neofetch
                  # onefetch
                  # vim
                  # neovim
                  # emacs
                  # gh
                  # deno
                  # starship
                  # tmux
                  # jq
                  # rust
                  # go
                  # lua
                  # luajit
                  # luarocks -> not found?
                  # eza
                  # bat
                  # ffmpeg
                  # inetutils
                  # mkcert
                  # yt-dlp
                  # lazygit
                  # jless
                  # cloudflared
                  # httpie
                  # lua-language-server
                  # dart
                  # jdk-openjdk -> should be specified
                  # gradle
                  # maven
                  # kotlin
                  # clojure
                  # leiningen
                  # sbcl
                  # tree-sitter
                  # openssh
                  # dotnet-sdk
                ];
              }
            )
          ];
        };
      };
    };
}
