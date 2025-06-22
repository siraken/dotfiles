{ config, pkgs, ... }:
let
  username = "siraken";
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in {
  imports = [
    # ./environment/system-packages.nix
    # ./programs/bash.nix
    # ./programs/zsh.nix
    # ./programs/fish.nix
    # ./programs/tmux.nix
    # ./programs/direnv.nix
    # ./programs/starship.nix
  ];

  home = {
    stateVersion = "25.05";

    # Symlink configuration files
    file = {
      # Shell configurations
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
      ".config/starship.toml".source = "${dotfilesPath}/.config/starship.toml";
      ".config/git".source = "${dotfilesPath}/.config/git";
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

      # Git credential helper for macOS (handled by git config symlink)
      # ".config/git/conf.d/credential.conf".source = "${dotfilesPath}/.config/git/conf.d/os/macos.conf";

      # Zed settings (specific file)
      ".config/zed/settings.json".source = "${dotfilesPath}/.config/zed/settings.json";
    };
  };

  programs.home-manager.enable = true;
}
