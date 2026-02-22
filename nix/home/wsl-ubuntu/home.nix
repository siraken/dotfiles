{
  pkgs,
  lib,
  inputs,
  ...
}:
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
    # inputs.dotfiles-private.homeManagerModules.default
    # programs
    ../../programs/1password-shell-plugins
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/coding-agents
    # ../../programs/difftastic
    ../../programs/direnv
    ../../programs/emacs
    ../../programs/fish
    ../../programs/fzf
    ../../programs/gh-dash
    ../../programs/git
    ../../programs/gitui
    ../../programs/helix
    ../../programs/husky
    ../../programs/idea
    ../../programs/lazydocker
    ../../programs/mise
    ../../programs/nano
    ../../programs/neovide
    ../../programs/spotify-player
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zellij
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home = {
    stateVersion = "26.05";
    # preferXdgDirectories = true; # to be enabled
    sessionVariables = import ../../modules/variable.nix { };
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    file = {

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
