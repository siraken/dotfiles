# Binary caches for standalone home-manager on a Linux host whose Nix is not
# managed by NixOS (wsl-ubuntu, production servers). Written to the user's
# nix.conf as `extra-*` so the system defaults stay in effect.
#
# Nix only honours a user-level substituter when the user is in
# `trusted-users` (or the cache is in `trusted-substituters`) of the system
# nix.conf; otherwise it is ignored with a warning.
{ pkgs, ... }:
let
  caches = import ../nix-cache-list.nix;
in
{
  nix = {
    package = pkgs.nix;
    settings = {
      extra-substituters = caches.substituters;
      extra-trusted-public-keys = caches.trusted-public-keys;
    };
  };
}
