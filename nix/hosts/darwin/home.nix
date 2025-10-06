{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "siraken";
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    # ../../environment/system-packages.nix
    # ../../programs/bash.nix
    ../../programs/alacritty.nix
    ../../programs/bat.nix
    ../../programs/git.nix
    ../../programs/helix.nix
    ../../programs/kakoune.nix
    ../../programs/kitty.nix
    ../../programs/zsh.nix
    ../../programs/zoxide.nix
    # ../../programs/fish.nix
    ../../programs/tmux.nix
    ../../programs/yazi.nix
    ../../programs/yt-dlp.nix
    ../../programs/direnv.nix
    ../../programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";
    # preferXdgDirectories = true; # to be enabled
    # sessionVariables = import ../../modules/variable.nix;
    # sessionPath = import ../../modules/path.nix;

    file =
      import ../../modules/home-symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };

    shell = {
      enableShellIntegration = true;
    };

    activation = import ../../modules/home-activation.nix {
      inherit
        config
        pkgs
        lib
        dotfilesPath
        ;
    };
  };

  programs.home-manager.enable = true;
}
