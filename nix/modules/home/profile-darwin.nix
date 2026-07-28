# macOS-only additions on top of `profile-full.nix`.
#
# Kept as a separate module rather than a `lib.optionals pkgs.stdenv.isDarwin`
# inside `profile-full.nix`: `imports` must not depend on module arguments that
# are themselves derived from the configuration, so the platform split is made
# explicit at the host level instead.
{ ... }:
{
  imports = [
    # programs (macOS only)
    ../../programs/difftastic
    ../../programs/ghostty
    ../../programs/kitty
    ../../programs/wezterm
    ../../programs/zed
    # services (macOS only)
    ../../services/darwin/aerospace.nix
    ../../services/darwin/jankyborders.nix
  ];
}
