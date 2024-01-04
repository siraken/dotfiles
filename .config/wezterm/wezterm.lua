--
-- Configuration
--
-- https://wezfurlong.org/wezterm/config/files.html
--

require("status")
local wezterm = require("wezterm")
local keybinds = require("keybinds")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.status_update_interval = 1000
config.colors = {
  scrollbar_thumb = "white",
}
config.color_scheme = "Tokyo Night"
config.font_size = 16
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Hack Nerd Font Mono",
  "Fira Code",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 15
config.win32_system_backdrop = "Acrylic"
-- config.macos_window_dragging_behavior = "all"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_gradient = {
  orientation = "Vertical",
  colors = {
    "#0f0c29",
    "#302b63",
    "#24243e",
  },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 64,
}

return config