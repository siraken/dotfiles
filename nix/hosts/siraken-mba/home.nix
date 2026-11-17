{ lib, pkgs, ... }:
{
  imports = [
    # standard rather than full to keep this 8 GB machine light, plus the
    # coding agents from full.
    ../../home/profiles/standard.nix
    ../../modules/home/nixos-host.nix
    ../../programs/coding-agents
    ./cli.nix
    ../../programs/hyprland
    ../../programs/wezterm
    # Only home-manager on NixOS is switched once it boots (#243), and /home
    # is shared with the Omarchy install. Keep its ~/.config/hypr and
    # ~/.config/omarchy links so Omarchy stays usable as a recovery system;
    # NixOS's Hyprland reads config/hypr-nixos instead. Drop this when Omarchy
    # is removed (#244).
    ../../programs/omarchy
  ];

  # Not installed for the first switch on NixOS: codex builds from source here
  # (see the codex WORKAROUND in nix/lib/overlays.nix), which takes about an
  # hour on this machine. Its config is still written. Drop this once codex
  # is in the store (#243).
  programs.codex.package = lib.mkForce null;

  home.packages = with pkgs; [
    # The browser the Hyprland bindings launch, and a second one.
    google-chrome
    firefox
    discord
    obsidian
    spotify
    # Video and images; windows.lua floats them.
    mpv
    imv
  ];

  # The repo is checked out at ~/dotfiles, as on the daily drivers.
  dotfiles.linkMode = "outOfStore";

  home.stateVersion = "26.11";
}
