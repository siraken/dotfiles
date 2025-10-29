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
    # programs
    ../../programs/alacritty.nix
    ../../programs/bash.nix
    ../../programs/bat.nix
    ../../programs/bottom.nix
    ../../programs/direnv.nix
    ../../programs/fish.nix
    ../../programs/git.nix
    ../../programs/helix.nix
    ../../programs/kakoune.nix
    ../../programs/kitty.nix
    ../../programs/lazydocker.nix
    ../../programs/lazygit.nix
    ../../programs/neovide.nix
    ../../programs/starship.nix
    ../../programs/tmux.nix
    ../../programs/vim.nix
    # ../../programs/vscode.nix
    ../../programs/yazi.nix
    ../../programs/yt-dlp.nix
    ../../programs/zed.nix
    ../../programs/zoxide.nix
    ../../programs/zsh.nix
    # services
    ../../services/aerospace.nix
    ../../services/jankyborders.nix
  ];

  home = {
    stateVersion = "25.11";
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
