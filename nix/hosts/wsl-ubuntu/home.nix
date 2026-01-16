{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "1password-cli"
        ];
    };
  };

  imports = [
    inputs.op-shell-plugins.hmModules.default
    # programs
    ../../programs/1password-shell-plugins.nix
    ../../programs/atuin.nix
    ../../programs/bash
    ../../programs/bat.nix
    ../../programs/bottom.nix
    ../../programs/coding-agents.nix
    # ../../programs/difftastic.nix
    ../../programs/direnv.nix
    ../../programs/emacs.nix
    ../../programs/fish
    ../../programs/fzf.nix
    ../../programs/git.nix
    ../../programs/helix.nix
    ../../programs/lazydocker.nix
    ../../programs/lazygit.nix
    ../../programs/mise.nix
    ../../programs/neovide.nix
    ../../programs/starship.nix
    ../../programs/tmux.nix
    ../../programs/vim.nix
    ../../programs/yazi.nix
    ../../programs/yt-dlp.nix
    ../../programs/zoxide.nix
    ../../programs/zsh
  ];

  home = {
    stateVersion = "25.11";
    # preferXdgDirectories = true; # to be enabled
    # sessionVariables = import ../../modules/variable.nix;
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { };

    file =
      import ../../modules/home-symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableShellIntegration = true;
    };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      # wsl-ubuntu specific
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
      pkgs.nixfmt
    ];
  };

  programs.home-manager.enable = true;
}
