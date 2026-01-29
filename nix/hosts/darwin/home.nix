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
    ../../programs/alacritty.nix
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
    ../../programs/ghostty.nix
    ../../programs/git.nix
    ../../programs/helix.nix
    ../../programs/kitty.nix
    ../../programs/lazydocker.nix
    ../../programs/lazygit.nix
    ../../programs/mise.nix
    ../../programs/starship.nix
    ../../programs/tmux.nix
    ../../programs/vim.nix
    # ../../programs/vscode.nix
    ../../programs/yazi.nix
    ../../programs/yt-dlp.nix
    ../../programs/zoxide.nix
    ../../programs/zsh
    # programs (darwin-only)
    ../../programs/darwin/1password-shell-plugins.nix
    ../../programs/darwin/neovide.nix
    ../../programs/darwin/zed.nix
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
      ln -sfn ${dotfilesPath}/.config/wezterm $HOME/.config/wezterm
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
