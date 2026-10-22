# MacBook Air running Omarchy (Arch Linux + Hyprland).
#
# Omarchy owns the OS layer and its own user config (~/.bashrc, starship,
# terminals, ~/.config/hypr), so this host starts empty and takes over pieces
# one at a time rather than importing a profile wholesale.
{ lib, ... }:
{
  home.stateVersion = "26.05";

  imports = [
    ../../modules/home/mk-repo-link.nix
    ../../programs/wezterm
  ];

  # WezTerm itself comes from pacman: a nixpkgs GUI build needs the non-NixOS
  # GPU setup to render. Only the repo config is linked.
  programs.wezterm.enable = lib.mkForce false;

  targets.genericLinux.enable = true;

  dotfiles.linkMode = "outOfStore";
}
