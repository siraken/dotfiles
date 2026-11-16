-- Session services. They start here rather than as home-manager systemd user
-- units: ~/.config/systemd/user is shared with Omarchy until it is removed, and
-- a unit wanted by graphical-session.target would start there as well.
-- fcitx5 comes from NixOS's XDG autostart entry, hypridle and the polkit agent
-- from NixOS user units.

o.launch_on_start("waybar")
o.launch_on_start("mako")
o.launch_on_start("wl-paste --type text --watch cliphist store")
o.launch_on_start("wl-paste --type image --watch cliphist store")
