# The full workstation profile: `profile-core` plus the interactive tooling that
# every daily-driver machine shares (siraken-mbp, siraken-macmini, wsl-ubuntu,
# wsl-nixos). `nixos-vm` deliberately stays on `profile-core`.
#
# macOS-only additions live in `profile-darwin.nix`.
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./profile-core.nix
    inputs.op-shell-plugins.hmModules.default
    # programs (cross-platform)
    ../../programs/1password-shell-plugins
    ../../programs/coding-agents
    ../../programs/emacs
    ../../programs/husky
    ../../programs/nano
    ../../programs/neovide
  ];

  home = {
    sessionVariables = import ../variable.nix { };

    packages = lib.optionals pkgs.stdenv.isLinux [
      pkgs.gcc
      pkgs.libgcc
      pkgs.xdg-utils
    ];
  };
}
