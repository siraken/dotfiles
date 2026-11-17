-- Session services started with Hyprland. hypridle and the polkit agent are
-- NixOS user units, fcitx5 is NixOS's XDG autostart entry, and swaync is the
-- user unit its package ships, started by D-Bus on the first notification or
-- when Waybar's notification button connects (started here as well, the
-- second copy failed with "already running").

o.launch_on_start("waybar")
-- GTK's Vulkan renderer is incomplete on Haswell; GL draws the OSD fine.
o.launch_on_start("env GSK_RENDERER=gl swayosd-server")
o.launch_on_start("hyprpaper")
-- The night light on a schedule (hyprsunset.conf).
o.launch_on_start("hyprsunset")
o.launch_on_start("wl-paste --type text --watch cliphist store")
o.launch_on_start("wl-paste --type image --watch cliphist store")
-- In the background, for its browser integration and quick access.
o.launch_on_start("1password --silent")
