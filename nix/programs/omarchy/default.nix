# User config for an Omarchy host. Omarchy ships its defaults under
# /usr/share/omarchy and leaves only override files in ~/.config, so those are
# linked here as whole directories: an Omarchy migration that rewrites one of
# them then lands in the checkout and shows up in `git diff` instead of
# silently replacing a per-file symlink.
{ mkRepoLink, ... }:
{
  # Requires Omarchy's Lua bootstrap; not usable with a plain Hyprland.
  home.file.".config/hypr".source = mkRepoLink "config/hypr";

  # shell.json (bar layout), menu extensions, hooks, branding. `omarchy bar`
  # and the bar itself rewrite shell.json with a tmpfile + mv, which would
  # replace a per-file symlink.
  home.file.".config/omarchy".source = mkRepoLink "config/omarchy";

  # Show the fcitx5 input method in the bar's tray: Omarchy starts fcitx5 with
  # `--disable notificationitem`.
  home.file.".config/systemd/user/omarchy-fcitx5.service.d/tray.conf".source =
    mkRepoLink "config/systemd/user/omarchy-fcitx5.service.d/tray.conf";
}
