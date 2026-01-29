{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home = {
    stateVersion = "25.11";

    packages = with pkgs; [
      # Basic tools
      eza
      bat
      ripgrep
      fd
      fzf
      htop
      neofetch
      tmux
      lazygit
    ];
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "siraken";
      userEmail = "sirakensbl@gmail.com";
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    starship.enable = true;
    zoxide.enable = true;
    direnv.enable = true;
  };
}
