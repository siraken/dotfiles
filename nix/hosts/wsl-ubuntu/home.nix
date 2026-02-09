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
    # modules
    ../../modules/aliases.nix
    ../../modules/variable.nix
    ../../modules/path.nix
    ../../modules/nixpkgs.nix
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
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zellij
    ../../programs/zoxide
    ../../programs/zsh
  ];

  dotfiles.aliases.enable = true;
  dotfiles.variables.enable = true;
  dotfiles.path.enable = true;
  dotfiles.packages = {
    enable = true;
    extraPackages = with pkgs; [
      # wsl-ubuntu specific
      gcc
      libgcc
      xdg-utils
      nixfmt
    ];
  };

  home = {
    stateVersion = "25.11";
    # preferXdgDirectories = true; # to be enabled

    file = {

    };

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableShellIntegration = true;
    };
  };

  programs.home-manager.enable = true;
}
