# The full workstation profile: `standard` plus the interactive tooling that
# every daily-driver machine shares (siraken-mbp, siraken-macmini, wsl-ubuntu,
# wsl-nixos). `nixos-vm` deliberately stays on `standard`.
#
# macOS-only additions live in `darwin.nix`.
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./standard.nix
    inputs.op-shell-plugins.hmModules.default
    # programs (cross-platform)
    ../../programs/1password-shell-plugins
    ../../programs/coding-agents
    ../../programs/difftastic
    ../../programs/emacs
    ../../programs/husky
    ../../programs/nano
    ../../programs/neovide
  ];

  # Daily drivers always have the repo checked out at ~/dotfiles, so link repo
  # files out of the store and keep them editable in place.
  dotfiles.linkMode = lib.mkDefault "outOfStore";

  home = {
    sessionPath = [ "$COMPOSER_HOME/vendor/bin" ];
    sessionVariables = import ../../modules/variable.nix { inherit lib pkgs; };

    shellAliases = (import ../../modules/aliases.nix { inherit pkgs; }).full;
    packages =
      (import ../../modules/packages.nix { inherit pkgs; }).full
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
        pkgs.gcc
        pkgs.libgcc
        pkgs.xdg-utils
      ];
  };
}
