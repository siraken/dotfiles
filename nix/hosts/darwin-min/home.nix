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
    ../../programs/alacritty
    ../../programs/atuin
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/coding-agents
    # ../../programs/difftastic
    ../../programs/direnv
    ../../programs/emacs
    ../../programs/fish
    ../../programs/fzf
    ../../programs/ghostty
    ../../programs/git
    ../../programs/helix
    ../../programs/kitty
    ../../programs/lazydocker
    ../../programs/lazygit
    ../../programs/mise
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    # ../../programs/vscode
    ../../programs/yazi
    ../../programs/yt-dlp
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
    stateVersion = "25.11";
    # preferXdgDirectories = true; # to be enabled
    # sessionVariables = import ../../modules/variable.nix;
    sessionPath = import ../../modules/path.nix { };
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };

    file =
      import ../../modules/home-symlinks.nix {
        inherit config dotfilesPath;
      }
      // {

      };

    activation.mutableSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Mutable symlinks (not managed by Nix store)
      ln -sfn ${dotfilesPath}/.config/nvim $HOME/.config/nvim
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
