-- Apps started with Hyprland. The session services are systemd user units
-- instead: Waybar, swayosd, hyprpaper, hyprsunset, cliphist and the polkit
-- agent from home-manager (nix/programs/hyprland), hypridle from NixOS, swaync
-- from its package (D-Bus activated), fcitx5 from NixOS's XDG autostart entry.

-- In the background, for its browser integration and quick access.
o.launch_on_start("1password --silent")
