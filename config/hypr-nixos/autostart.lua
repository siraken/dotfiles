-- Session services. They start here rather than as home-manager systemd user
-- units: ~/.config/systemd/user is shared with Omarchy until it is removed, and
-- a unit wanted by graphical-session.target would start there as well.
-- hypridle and the polkit agent are NixOS user units.

o.launch_on_start("waybar")
o.launch_on_start("swaync")
-- GTK's Vulkan renderer is incomplete on Haswell; GL draws the OSD fine.
o.launch_on_start("env GSK_RENDERER=gl swayosd-server")
-- -c: hyprpaper would read ~/.config/hypr/hyprpaper.conf, Omarchy's.
o.launch_on_start("hyprpaper -c " .. o.dir .. "/hyprpaper.conf")
o.launch_on_start("wl-paste --type text --watch cliphist store")
o.launch_on_start("wl-paste --type image --watch cliphist store")

-- Not NixOS's XDG autostart entry: Omarchy hides it with
-- ~/.config/autostart/org.fcitx.Fcitx5.desktop (it starts fcitx5 itself), and
-- that file is shared until #244.
o.launch_on_start("fcitx5 --replace")
