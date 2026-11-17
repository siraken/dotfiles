# CLI tools from the `full` profile, picked one by one: the machine stays on
# `standard` to keep its 8 GB light (#283).
{ inputs, pkgs, ... }:
{
  imports = [
    inputs.op-shell-plugins.hmModules.default
    # The `op` CLI with its shell plugins (cachix among them).
    ../../programs/1password-shell-plugins
    ../../programs/fastfetch
  ];

  # From the `full` tier of modules/packages.nix.
  home.packages = with pkgs; [
    gum
    glab
    pnpm
    bun
    devenv
    rclone
    mkcert
    pandoc
  ];
}
