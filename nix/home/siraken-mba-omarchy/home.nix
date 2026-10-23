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
    ../../programs/bash
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

  # Rebuild Omarchy's own ~/.bashrc (/etc/skel/.bashrc) around the repo
  # fragments. env-bootstrap must run before the interactive guard (OMARCHY_PATH
  # and PATH for non-interactive shells too). Omarchy's rc runs last: the
  # nix.sh that `targets.genericLinux` sources prepends ~/.nix-profile/bin, and
  # only a later `mise activate` puts mise back in front of it. The rc owns
  # history (HISTSIZE=32768, ignoreboth), bash-completion, mise, starship,
  # zoxide and fzf, so none of those are enabled here.
  programs.bash = {
    # The login shell is pacman's /usr/bin/bash; a nixpkgs bash ahead of it on
    # PATH would make `bash` a different shell from the one you log in to.
    package = lib.mkForce null;
    bashrcExtra = ''
      [[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap
    '';
    initExtra = lib.mkAfter ''
      source "$OMARCHY_PATH/default/bash/rc"
    '';
  };

  targets.genericLinux.enable = true;

  dotfiles.linkMode = "outOfStore";
}
