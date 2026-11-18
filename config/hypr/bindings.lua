-- Omarchy's default bindings, minus the ones for its own menus, panels and
-- web apps. List the active ones with: hyprctl binds

-- Applications.
o.bind("SUPER + RETURN", "Terminal", o.launch("wezterm"))
-- foot needs no GPU setup of its own, for when WezTerm does not start.
o.bind("SUPER + ALT + RETURN", "Terminal (foot)", o.launch("foot"))
o.bind("SUPER + SHIFT + RETURN", "Browser", o.launch("google-chrome-stable"))
o.bind("SUPER + SHIFT + B", "Browser", o.launch("google-chrome-stable"))
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", o.launch("google-chrome-stable --incognito"))
o.bind("SUPER + SHIFT + F", "File manager", o.launch("nautilus --new-window"))
o.bind("SUPER + SHIFT + SLASH", "Passwords", o.launch("1password"))
o.bind("SUPER + CTRL + T", "Activity", o.launch("wezterm start --class TUI.float -- btop"))

-- Launcher and menus.
o.bind("SUPER + SPACE", "Launcher", "pkill -x rofi || " .. o.launch("rofi -show drun"))
-- Menus (scripts/menu), with Omarchy's keys.
local menu = "pkill -x rofi || " .. o.script("menu") .. " "
o.bind("SUPER + ALT + SPACE", "Menu", menu .. "root")
o.bind("SUPER + CTRL + E", "Emoji", menu .. "emoji")
o.bind("SUPER + CTRL + C", "Capture menu", menu .. "capture")
o.bind("SUPER + CTRL + O", "Toggle menu", menu .. "toggles")
o.bind("SUPER + K", "Keybindings", menu .. "keys")
o.bind("SUPER + ESCAPE", "System menu", "pkill wlogout || wlogout -b 3 -T 280 -B 280")
o.bind("XF86PowerOff", "System menu", "pkill wlogout || wlogout -b 3 -T 280 -B 280", { locked = true })
o.bind("SUPER + CTRL + V", "Clipboard history", o.script("clipboard-menu"))
o.bind("SUPER + SHIFT + SPACE", "Toggle top bar", "pkill -SIGUSR1 waybar")

-- Universal copy / paste / cut: SUPER + C / V / X send the app's own shortcut,
-- with the terminal variants for windows tagged terminal (see windows.lua).
-- The down/up split works around send_shortcut sometimes leaving the key
-- stuck: https://github.com/hyprwm/Hyprland/discussions/14099
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function active_window_is_terminal()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    if tag:gsub("%*$", "") == "terminal" then
      return true
    end
  end

  return false
end

local function universal_clipboard_shortcut(default_mods, default_key, terminal_mods, terminal_key)
  return function()
    if active_window_is_terminal() then
      send_shortcut_once(terminal_mods, terminal_key)()
    else
      send_shortcut_once(default_mods, default_key)()
    end
  end
end

o.bind("SUPER + C", "Universal copy", universal_clipboard_shortcut("CTRL", "C", "CTRL", "Insert"))
o.bind("SUPER + V", "Universal paste", universal_clipboard_shortcut("CTRL", "V", "SHIFT", "Insert"))
o.bind("SUPER + X", "Universal cut", send_shortcut_once("CTRL", "X"))

-- Windows.
o.bind("SUPER + W", "Close window", hl.dsp.window.close())
o.bind("SUPER + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + P", "Pseudo window", hl.dsp.window.pseudo())
o.bind("SUPER + T", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + ALT + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))

o.bind("SUPER + LEFT", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + RIGHT", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + UP", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + DOWN", "Focus on below window", hl.dsp.focus({ direction = "d" }))

o.bind("SUPER + SHIFT + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

o.bind("ALT + TAB", "Focus on next window", hl.dsp.window.cycle_next())
o.bind("ALT + SHIFT + TAB", "Focus on previous window", hl.dsp.window.cycle_next({ next = false }))
o.bind("ALT + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())
o.bind("ALT + SHIFT + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())

-- code:20 / code:21 are the keys right of 0 (- and = on US, - and ^ on JIS).
o.bind("SUPER + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind("SUPER + SHIFT + code:20", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
o.bind("SUPER + SHIFT + code:21", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

o.bind("SUPER + mouse:272", "Move window", hl.dsp.window.drag(), { mouse = true })
o.bind("SUPER + mouse:273", "Resize window", hl.dsp.window.resize(), { mouse = true })

-- Groups.
o.bind("SUPER + G", "Toggle window grouping", hl.dsp.group.toggle())
o.bind("SUPER + ALT + G", "Move active window out of group", hl.dsp.window.move({ out_of_group = true }))
o.bind("SUPER + ALT + LEFT", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + ALT + RIGHT", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))
o.bind("SUPER + ALT + UP", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + ALT + DOWN", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))
o.bind("SUPER + ALT + TAB", "Next window in group", hl.dsp.group.next())
o.bind("SUPER + ALT + SHIFT + TAB", "Previous window in group", hl.dsp.group.prev())
o.bind("SUPER + CTRL + LEFT", "Move grouped window focus left", hl.dsp.group.prev())
o.bind("SUPER + CTRL + RIGHT", "Move grouped window focus right", hl.dsp.group.next())

-- Workspaces. code:10 to code:19 are the 1 to 0 keys on any layout.
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  o.bind("SUPER + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
  o.bind(
    "SUPER + SHIFT + " .. key,
    "Move window to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace) })
  )
  o.bind(
    "SUPER + SHIFT + ALT + " .. key,
    "Move window silently to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace), follow = false })
  )
end

o.bind("SUPER + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind(
  "SUPER + ALT + S",
  "Move window to scratchpad",
  hl.dsp.window.move({ workspace = "special:scratchpad", follow = false })
)

o.bind("SUPER + TAB", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + SHIFT + TAB", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
o.bind("SUPER + CTRL + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))
o.bind("SUPER + mouse_down", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + mouse_up", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" }))

o.bind("SUPER + SHIFT + ALT + LEFT", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + SHIFT + ALT + RIGHT", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
o.bind("CTRL + ALT + TAB", "Focus on next monitor", hl.dsp.focus({ monitor = "+1" }))
o.bind("CTRL + ALT + SHIFT + TAB", "Focus on previous monitor", hl.dsp.focus({ monitor = "-1" }))

-- Volume, brightness and keyboard backlight, shown by swayosd. With fnmode=2
-- these are Fn + F1 to F12. They work on the lock screen too.
local osd = o.script("osd") .. " "
local hardware = { locked = true, repeating = true }

o.bind("XF86AudioRaiseVolume", "Volume up", osd .. "volume raise", hardware)
o.bind("XF86AudioLowerVolume", "Volume down", osd .. "volume lower", hardware)
o.bind("ALT + XF86AudioRaiseVolume", "Volume up precise", osd .. "volume raise-fine", hardware)
o.bind("ALT + XF86AudioLowerVolume", "Volume down precise", osd .. "volume lower-fine", hardware)
o.bind("XF86AudioMute", "Mute", osd .. "volume mute-toggle", { locked = true })
o.bind("XF86AudioMicMute", "Mute microphone", osd .. "mic mute-toggle", { locked = true })

o.bind("XF86MonBrightnessUp", "Brightness up", osd .. "brightness raise", hardware)
o.bind("XF86MonBrightnessDown", "Brightness down", osd .. "brightness lower", hardware)
o.bind("ALT + XF86MonBrightnessUp", "Brightness up precise", osd .. "brightness raise-fine", hardware)
o.bind("ALT + XF86MonBrightnessDown", "Brightness down precise", osd .. "brightness lower-fine", hardware)
o.bind("XF86KbdBrightnessUp", "Keyboard brightness up", osd .. "keyboard raise", hardware)
o.bind("XF86KbdBrightnessDown", "Keyboard brightness down", osd .. "keyboard lower", hardware)

o.bind("XF86AudioNext", "Next track", "playerctl next", { locked = true })
o.bind("XF86AudioPause", "Pause", "playerctl play-pause", { locked = true })
o.bind("XF86AudioPlay", "Play", "playerctl play-pause", { locked = true })
o.bind("XF86AudioPrev", "Previous track", "playerctl previous", { locked = true })
o.bind("XF86Eject", "Eject media", "eject", { locked = true })

-- Notifications (swaync).
o.bind("SUPER + comma", "Dismiss last notification", "swaync-client --close-latest")
o.bind("SUPER + SHIFT + comma", "Dismiss all notifications", "swaync-client --close-all")
o.bind("SUPER + SHIFT + ALT + comma", "Notification center", "swaync-client --toggle-panel")
o.bind("SUPER + CTRL + comma", "Toggle silencing notifications", "swaync-client --toggle-dnd")

-- Screenshots, colour picker, night light, lock.
o.bind("PRINT", "Screenshot (region)", o.script("screenshot", "region"))
o.bind("CTRL + PRINT", "Screenshot (window)", o.script("screenshot", "window"))
o.bind("ALT + PRINT", "Screen recording (start / stop)", o.script("record", "screen"))
o.bind("SHIFT + PRINT", "Screenshot (screen)", o.script("screenshot", "screen"))
o.bind("SUPER + PRINT", "Color picker", "pkill hyprpicker || hyprpicker -a")
o.bind("SUPER + CTRL + N", "Toggle nightlight", o.script("nightlight"))
o.bind("SUPER + CTRL + L", "Lock system", "loginctl lock-session")

o.bind("SUPER + CTRL + Z", "Zoom in", function()
  local zoom = hl.get_config("cursor.zoom_factor") or 1
  hl.config({ cursor = { zoom_factor = zoom + 1 } })
end)

o.bind("SUPER + CTRL + ALT + Z", "Reset zoom", function()
  hl.config({ cursor = { zoom_factor = 1 } })
end)
