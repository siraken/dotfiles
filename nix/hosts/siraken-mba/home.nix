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
  ];

  # Only Claude Code is used here; the other agents keep their configuration
  # (#286).
  dotfiles.codingAgents.agents = [ "claude-code" ];

  # Not used on this machine (#286).
  programs.awscli.enable = lib.mkForce false;

  home.packages = with pkgs; [
    # The browser the Hyprland bindings launch, and a second one.
    google-chrome
    firefox
    discord
    slack
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
