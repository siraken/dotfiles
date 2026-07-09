{
  pkgs,
  inputs,
  mkRepoLink,
  ...
}:
{
  imports = [
    ../../modules/home/mk-repo-link.nix
    inputs.op-shell-plugins.hmModules.default
    # inputs.dotfiles-private.homeManagerModules.default
    # programs (cross-platform)
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/coding-agents
    ../../programs/difftastic
    ../../programs/direnv
    ../../programs/fastfetch
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
    ../../programs/scripts
    ../../programs/spotify-player
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    # ../../programs/vscode
    ../../programs/yazi
    ../../programs/zed
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

    # Mutable (out-of-store) symlinks: edited in place, no rebuild required.
    file = {
      ".config/wezterm".source = mkRepoLink "config/wezterm";
      ".claude/settings.json".source = mkRepoLink "home/.claude/settings.json";
    };

    shell = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableShellIntegration = true;
    };

    packages = import ../../modules/nixpkgs.nix { inherit pkgs; } ++ [
    ];
  };

  programs.home-manager.enable = true;
  programs.man.generateCaches = false;
}
