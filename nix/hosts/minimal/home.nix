{ config, pkgs, lib, inputs, ... }:
let
  username = "siraken";
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in {
  imports = [
    ../../programs/zoxide.nix
    ../../programs/git.nix
    ../../programs/zsh.nix
    ../../programs/tmux.nix
    ../../programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";

    # Symlink configuration files
    file = {
      # Shell configurations
      ".bashrc".source = "${dotfilesPath}/.config/bash/.bashrc";
      ".bash_profile".source = "${dotfilesPath}/.config/bash/.bash_profile";
      ".zprofile".source = "${dotfilesPath}/.config/zsh/.zprofile";
      ".zshrc".source = "${dotfilesPath}/.config/zsh/.zshrc";

      # Simple bar
      ".simplebarrc".source = "${dotfilesPath}/.config/simple-bar/.simplebarrc";

      # Vim
      ".vimrc".source = "${dotfilesPath}/.config/vim/.vimrc";
      ".ideavimrc".source = "${dotfilesPath}/.config/idea/.ideavimrc";

      # Hyper
      ".hyper.js".source = "${dotfilesPath}/.config/hyper/.hyper.js";

      # VSCode snippets
      ".vsnip".source = "${dotfilesPath}/.vsnip";

      # XDG config directories
      ".config/kitty".source = "${dotfilesPath}/.config/kitty";
      ".config/bash".source = "${dotfilesPath}/.config/bash";
      ".config/zsh".source = "${dotfilesPath}/.config/zsh";
      ".config/fish".source = "${dotfilesPath}/.config/fish";
      ".config/husky".source = "${dotfilesPath}/.config/husky";
      ".config/mise".source = "${dotfilesPath}/.config/mise";
      ".config/ranger".source = "${dotfilesPath}/.config/ranger";
      ".config/git/hooks".source = "${dotfilesPath}/.config/git/hooks";
      # ".config/emacs".source = "${dotfilesPath}/.config/emacs"; # Contains unsupported file types (sockets)
      ".config/nano".source = "${dotfilesPath}/.config/nano";
      ".config/nvim".source = "${dotfilesPath}/.config/nvim";
      ".config/neovide".source = "${dotfilesPath}/.config/neovide";
      ".config/helix".source = "${dotfilesPath}/.config/helix";
      ".config/kak".source = "${dotfilesPath}/.config/kak";
      ".config/alacritty".source = "${dotfilesPath}/.config/alacritty";
      ".config/wezterm".source = "${dotfilesPath}/.config/wezterm";
      ".config/ghostty".source = "${dotfilesPath}/.config/ghostty";
      ".config/yt-dlp".source = "${dotfilesPath}/.config/yt-dlp";
      ".config/bat".source = "${dotfilesPath}/.config/bat";
      ".config/sketchybar".source = "${dotfilesPath}/.config/sketchybar";
      ".config/borders".source = "${dotfilesPath}/.config/borders";

      # Zed settings (specific file)
      ".config/zed/settings.json".source = "${dotfilesPath}/.config/zed/settings.json";

      # Claude configuration
      ".claude/commands".source = "${dotfilesPath}/.config/claude/commands";
      ".claude/settings.json".source = "${dotfilesPath}/.config/claude/settings.json";
      ".claude/CLAUDE.md".source = "${dotfilesPath}/.config/claude/CLAUDE.md";

      # Gemini configuration
      ".gemini/settings.json".source = "${dotfilesPath}/.config/gemini/settings.json";
    };

    packages = [
      pkgs.eza
      pkgs.bat
      pkgs.neovim
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
      pkgs.jq
    ];
  };

  programs.home-manager.enable = true;
}
