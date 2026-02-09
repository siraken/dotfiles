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
    # inputs.dotfiles-private.homeManagerModules.default
    # modules
    ../../modules/aliases.nix
    ../../modules/variable.nix
    ../../modules/path.nix
    ../../modules/nixpkgs.nix
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

  dotfiles.aliases.enable = true;
  dotfiles.variables.enable = true;
  dotfiles.path.enable = true;
  dotfiles.packages = {
    enable = true;
    extraPackages = with pkgs; [
      nixfmt
    ];
  };

  home = {
    stateVersion = "25.11";
    # preferXdgDirectories = true; # to be enabled

    file = {

    };

    activation.mutableSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ln -sfn ${dotfilesPath}/nix/programs/nvim/config $HOME/.config/nvim
      ln -sfn ${dotfilesPath}/nix/programs/wezterm/config $HOME/.config/wezterm
      ln -sfn ${dotfilesPath}/.agents/claude/settings.json $HOME/.claude/settings.json
    '';

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableShellIntegration = true;
    };
  };

  programs.home-manager.enable = true;
}
