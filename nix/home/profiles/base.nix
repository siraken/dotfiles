# The smallest home-manager profile: what a production server or any host that
# is only visited over SSH needs, and nothing else.
#
# Profiles stack: `base` ⊂ `standard` ⊂ `full`. Every profile is plain
# home-manager, independent of nix-darwin / NixOS, so the same profile applies
# unchanged on macOS and Linux.
{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home/mk-repo-link.nix
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/fzf
    ../../programs/git
    ../../programs/starship
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home = {
    # preferXdgDirectories = true; # to be enabled
    sessionPath = import ../../modules/path.nix { inherit lib pkgs; };

    # `mkDefault` so a host that leaves a shell out (fish on wsl-nixos and
    # nixos-vm) can switch its integration off.
    shell = {
      enableBashIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableShellIntegration = lib.mkDefault true;
    };
  };

  programs = {
    home-manager.enable = true;

    # Building the man page cache is expensive and it is regenerated whenever a
    # package changes. Previously set on siraken-mbp only, which left every
    # other host paying for it.
    man.generateCaches = false;
  };
}
