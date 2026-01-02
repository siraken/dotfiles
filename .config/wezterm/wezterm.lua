--
-- Configuration
--
-- https://wezfurlong.org/wezterm/config/files.html
--

require("status")
require("event")
require("format")

local wezterm = require("wezterm")
local keybinds = require("keybinds")
local mouse_bindings = require("mousebinds")
local config = {}

local is_mac = string.find(wezterm.target_triple, "apple")
local is_win = wezterm.target_triple == "x86_64-pc-windows-msvc"
local is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu"

local act = wezterm.action
local mux = wezterm.mux

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on("bell", function(window, pane)
  window:toast_notification("Claude Code", "Task completed", nil, 4000)
end)

config.automatically_reload_config = true
config.audible_bell = "SystemBeep"
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.mouse_bindings = mouse_bindings
config.use_ime = true
config.default_prog = { "/bin/bash", "-l" }
if is_mac then
  config.default_prog = { "bash", "-l" }
  config.font_size = 16
  config.line_height = 1.2
  config.window_background_opacity = 0.85
  config.macos_window_background_blur = 10
  -- config.macos_window_dragging_behavior = "all"
elseif is_win then
  config.default_prog = { "pwsh.exe" }
  config.font_size = 12
  config.window_background_opacity = 0.85
  config.win32_system_backdrop = "Acrylic"
elseif is_linux then
  config.font_size = 14
  config.line_height = 1.2
  config.window_background_opacity = 0.85
else
  config.font_size = 14
  config.line_height = 1.2
  config.window_background_opacity = 0.85
end
config.exit_behavior = "Close"
config.status_update_interval = 1000
config.colors = {
  scrollbar_thumb = "white",
  tab_bar = {
    background = "none",
  },
}
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  { family = "Hack Nerd Font Mono", weight = "Regular", style = "Normal", stretch = "Normal" },
  -- { family = "Hack NF", weight = "Regular", style = "Normal", stretch = "Normal" },
  { family = "Consolas",            weight = "Regular", style = "Normal", stretch = "Normal" },
  { family = "Courier New",         weight = "Regular", style = "Normal", stretch = "Normal" },
  { family = "JetBrains Mono",      weight = "Regular", style = "Normal", stretch = "Normal" },
  { family = "Hiragino Sans",       weight = "Regular", style = "Normal", stretch = "Normal" },
  { family = "Noto Sans JP",        weight = "Regular", style = "Normal", stretch = "Normal" },
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
