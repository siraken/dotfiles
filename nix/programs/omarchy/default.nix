# User config for an Omarchy host. Omarchy ships its defaults under
# /usr/share/omarchy and leaves only override files in ~/.config, so those are
# linked here as whole directories: an Omarchy migration that rewrites one of
# them then lands in the checkout and shows up in `git diff` instead of
# silently replacing a per-file symlink.
{ mkRepoLink, ... }:
{
  # Requires Omarchy's Lua bootstrap; not usable with a plain Hyprland.
  home.file.".config/hypr".source = mkRepoLink "config/hypr";
}
