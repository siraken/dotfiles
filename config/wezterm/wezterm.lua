-- Modules that only register event handlers (status bar, events, tab titles)
require("status")
require("event")
require("format")

local wezterm = require("wezterm")
local keybinds = require("keybinds")
local mouse_bindings = require("mousebinds")

local is_darwin = string.find(wezterm.target_triple, "apple") ~= nil
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- General ----------------------------------------------------------------

config.automatically_reload_config = true
config.default_prog = { "bash", "-l" }
config.exit_behavior = "Close"
config.status_update_interval = 1000
config.use_ime = true

-- Keys & mouse -----------------------------------------------------------

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.mouse_bindings = mouse_bindings

-- Platform-specific ------------------------------------------------------
-- Must come before anything derived from font_size (e.g. the command palette).

if is_darwin then
  config.font_size = 16
  config.line_height = 1.2
  config.window_background_opacity = 0.7
  config.macos_window_background_blur = 13
  config.window_decorations = "RESIZE"
  -- config.macos_window_dragging_behavior = "all"
elseif is_windows then
  config.default_prog = { "wsl.exe" }
  config.default_cwd = ""
  config.font_size = 12
  config.window_background_opacity = 0.85
  config.win32_system_backdrop = "Mica"
else
  config.font_size = 14
  config.line_height = 1.2
  config.window_background_opacity = 0.85
  config.window_decorations = "RESIZE"
end

-- Colors -----------------------------------------------------------------

config.color_scheme = "Tokyo Night"
config.colors = {
  scrollbar_thumb = "white",
  tab_bar = {
    background = "none",
    inactive_tab_edge = "none",
  },
}

-- Font -------------------------------------------------------------------

local function font(family)
  return { family = family, weight = "Regular", style = "Normal", stretch = "Normal" }
end

config.font = wezterm.font_with_fallback({
  font("Hack Nerd Font Mono"),
  -- font("Hack NF"),
  font("Consolas"),
  font("Courier New"),
  font("JetBrains Mono"),
  font("Hiragino Sans"),
  font("Noto Sans JP"),
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false

-- Tab bar ----------------------------------------------------------------

config.enable_tab_bar = true
-- タブの管理は herdr に任せるので、wezterm 側が 1 タブのときはタブバーごと隠す。
-- status.lua の right status もタブバーに描かれるため一緒に消える。
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
-- config.show_close_tab_button_in_tabs = false

-- Command palette --------------------------------------------------------

config.command_palette_font_size = config.font_size * 1.5
config.command_palette_rows = 10
config.command_palette_bg_color = "#16161e"

-- Window -----------------------------------------------------------------

config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.3,
}

return config
