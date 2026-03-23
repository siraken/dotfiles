{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.op-shell-plugins.hmModules.default
    # programs (cross-platform)
    ../../programs/1password-shell-plugins
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/coding-agents
    ../../programs/direnv
    ../../programs/emacs
    # ../../programs/fish # disabled due to fisher hash mismatch
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
    sessionVariables = import ../../modules/variable.nix { };
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = false; # fish disabled
      enableZshIntegration = true;
      enableShellIntegration = true;
    };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      # wsl-nixos specific
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
    ];
  };

  programs.home-manager.enable = true;
}
