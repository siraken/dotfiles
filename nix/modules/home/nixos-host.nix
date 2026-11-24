# What home-manager used to inherit from NixOS while it was embedded as a NixOS
# module (`nixosConfig`), stated explicitly for standalone home-manager on a
# NixOS host (wsl-nixos, nixos-vm, siraken-mba).
#
# Keep in sync with the host's `configuration.nix`: all three hosts only set
# `i18n.defaultLocale = "en_US.UTF-8"` and leave fontconfig enabled.
{ lib, pkgs, ... }:
{
  # Without this, standalone home-manager defaults to the full glibcLocales
  # (every locale) instead of the two the system builds.
  i18n.glibcLocales = pkgs.glibcLocales.override {
    allLocales = false;
    locales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  # Defaulted to NixOS' `fonts.fontconfig.enable` (true) when embedded.
  fonts.fontconfig.enable = true;

  # NixOS hosts (including NixOS-WSL, which enforces native systemd) always run
  # a user systemd session, so Atuin's socket-activated daemon works here.
  # Home Manager gates this behind `programs.atuin.enable`, so it is a no-op on
  # hosts without Atuin.
  programs.atuin.daemon.enable = lib.mkDefault true;
}
