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
    # programs
    ../../programs/1password-shell-plugins.nix
    ../../programs/alacritty.nix
    # ../../programs/bash.nix
    ../../programs/bat.nix
    ../../programs/bottom.nix
    ../../programs/coding-agents.nix
    # ../../programs/difftastic.nix
    ../../programs/direnv.nix
    ../../programs/emacs.nix
    ../../programs/fish.nix
    ../../programs/fzf.nix
    ../../programs/ghostty.nix
    ../../programs/git.nix
    ../../programs/helix.nix
    ../../programs/kakoune.nix
    ../../programs/kitty.nix
    ../../programs/lazydocker.nix
    ../../programs/lazygit.nix
    ../../programs/mise.nix
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
    sessionPath = import ../../modules/path.nix { };

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
      ln -sfn ${dotfilesPath}/.agents/claude/CLAUDE.md $HOME/.claude/CLAUDE.md
    '';

    shell = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableShellIntegration = true;
    };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
      pkgs.nixfmt-rfc-style
    ];
  };

  programs.home-manager.enable = true;
}
