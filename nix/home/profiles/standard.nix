# `base` plus the interactive tooling for a host that is worked on but is not a
# daily driver (nixos-vm).
#
# The shell aliases and the package list still assume the tools of a full
# workstation (`vim = nvim`, `ll = eza`, language toolchains); they stay here
# until the package set is split per profile.
{
  pkgs,
  ...
}:
{
  imports = [
    ./base.nix
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/direnv
    ../../programs/gh-dash
    ../../programs/gitui
    ../../programs/helix
    ../../programs/lazydocker
    ../../programs/mise
    ../../programs/scripts
    ../../programs/tmux
    ../../programs/vim
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zellij
  ];

  home = {
    shellAliases = import ../../modules/aliases.nix { inherit pkgs; };
    packages = import ../../modules/nixpkgs.nix { inherit pkgs; };
  };
}
