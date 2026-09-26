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
    shellAliases = (import ../../modules/aliases.nix { inherit pkgs; }).base;
    packages = (import ../../modules/packages.nix { inherit pkgs; }).base;

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

    # The full git pulls in Python (git-p4 and friends), which on darwin drags
    # clang, llvm and the Apple SDK into the closure: ~1.2 GiB for a profile
    # meant for production servers. `standard` restores the full package.
    git.package = lib.mkDefault pkgs.gitMinimal;

    # Building the man page cache is expensive and it is regenerated whenever a
    # package changes. Previously set on siraken-mbp only, which left every
    # other host paying for it.
    man.generateCaches = false;
  };
}
