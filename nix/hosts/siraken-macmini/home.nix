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
  imports = [
    inputs.op-shell-plugins.hmModules.default
    # programs (cross-platform)
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/coding-agents
    ../../programs/difftastic
    ../../programs/direnv
    ../../programs/emacs
    ../../programs/fish
    ../../programs/fzf
    ../../programs/gh-dash
    ../../programs/ghostty
    ../../programs/git
    ../../programs/gitui
    ../../programs/helix
    ../../programs/husky
    ../../programs/idea
    ../../programs/kitty
    ../../programs/lazydocker
    ../../programs/mise
    ../../programs/nano
    ../../programs/spotify-player
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    # ../../programs/vscode
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zellij
    ../../programs/zoxide
    ../../programs/zsh
    # programs (cross-platform but optional)
    ../../programs/1password-shell-plugins
    ../../programs/neovide
    # services (darwin-only)
    ../../services/darwin/aerospace.nix
    ../../services/darwin/jankyborders.nix
  ];

  home = {
    stateVersion = "26.05";
    # preferXdgDirectories = true; # to be enabled
    sessionVariables = import ../../modules/variable.nix { };
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    file = {

    };

    activation.mutableSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sfn ${dotfilesPath}/nix/programs/wezterm/config $HOME/.config/wezterm
      ln -sfn ${dotfilesPath}/.agents/claude/settings.json $HOME/.claude/settings.json
    '';

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableShellIntegration = true;
    };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      pkgs.nixfmt
    ];
  };

  programs.home-manager.enable = true;
}
