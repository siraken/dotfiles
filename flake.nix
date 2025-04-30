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
      darwinSystem = "aarch64-darwin";
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

      # TODO: Add NixOS modules for your Linux machine
      nixosConfigurations = {
        your-linux-machine-name = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, ... }:
              {
                environment.systemPackages = with pkgs; [
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
