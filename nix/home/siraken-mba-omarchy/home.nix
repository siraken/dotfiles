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
    ../../programs/coding-agents
    ../../programs/omarchy
    ../../programs/wezterm
  ];

  # WezTerm itself comes from pacman: a nixpkgs GUI build needs the non-NixOS
  # GPU setup to render. Only the repo config is linked.
  programs.wezterm.enable = lib.mkForce false;

  # Omarchy installs the agents (mise + ~/.local/bin wrappers, ahead of
  # ~/.nix-profile on PATH); take only their configuration.
  dotfiles.codingAgents.installPackages = false;

  programs.opencode = {
    # Omarchy's wrapper owns updates. (Its default `"theme": "system"` is a TUI
    # key that opencode no longer reads from opencode.json.)
    settings.autoupdate = false;
    # herdr writes its TUI plugin to tui.jsonc; a tui.json next to it would
    # compete with it.
    tui = lib.mkForce { };
  };

  targets.genericLinux.enable = true;

  dotfiles.linkMode = "outOfStore";
}
