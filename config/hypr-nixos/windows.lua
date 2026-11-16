-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

o.window(".*", { suppress_event = "maximize" })

-- Fix dragging issues with XWayland.
o.window({
  class = "^$",
  title = "^$",
  xwayland = true,
  float = true,
  fullscreen = false,
  pin = false,
}, { no_focus = true })

-- Terminals, for the universal copy/paste bindings.
o.window("(org\\.wezfurlong\\.wezterm|com\\.mitchellh\\.ghostty|kitty|TUI\\..*)", { tag = "+terminal" })

-- Floating windows.
o.window({ tag = "floating-window" }, { float = true, center = true, size = { 875, 600 } })
o.window("(TUI\\.float|org\\.gnome\\.NautilusPreviewer|imv|mpv|org\\.pulseaudio\\.pavucontrol|blueman-manager)", {
  tag = "+floating-window",
})
o.window("xdg-desktop-portal-gtk", { tag = "+floating-window" })
o.window({
  class = "(org\\.gnome\\.Nautilus)",
  title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
}, { tag = "+floating-window" })

o.window("^(1[p|P]assword)$", { no_screen_share = true, tag = "+floating-window" })

-- Chromium-based browsers tile even when they ask to float.
o.window("((google-)?[cC]hrom(e|ium)|[bB]rave-browser)", { tile = true })

-- Hide screen-sharing notification windows.
o.window({ title = ".*is sharing.*" }, { workspace = "special silent" })

-- Picture-in-picture.
o.window({ title = "(Picture.?in.?[Pp]icture)" }, {
  float = true,
  pin = true,
  size = { 600, 338 },
  keep_aspect_ratio = true,
  border_size = 0,
})
