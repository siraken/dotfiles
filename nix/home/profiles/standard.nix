# `base` plus the interactive tooling for a host that is worked on but is not a
# daily driver (nixos-vm).
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./base.nix
    # nix-index + comma live in the user environment, not the OS layer, so the
    # same profile brings them on macOS, NixOS, and plain Linux alike.
    inputs.nix-index-database.homeModules.nix-index
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

  programs.nix-index-database.comma.enable = true;

  home = {
    shellAliases = (import ../../modules/aliases.nix { inherit pkgs; }).standard;
    packages = (import ../../modules/packages.nix { inherit pkgs; }).standard;
  };
}
