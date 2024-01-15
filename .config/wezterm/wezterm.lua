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
local config = {}

local is_mac = wezterm.target_triple == "x86_64-apple-darwin"
local is_win = wezterm.target_triple == "x86_64-pc-windows-msvc"
local is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu"

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.launch_menu = {
  {
    label = "fish on macOS",
    args = { "/opt/homebrew/bin/fish", "-l" },
  },
  {
    label = "fish on Linux",
    args = { "/usr/bin/fish", "-l" },
  },
}
if is_mac then
  config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
  config.font_size = 16
elseif is_win then
  config.default_prog = { "powershell.exe" }
  config.font_size = 14
elseif is_linux then
  config.default_prog = { "/usr/bin/fish", "-l" }
  config.font_size = 16
else
  config.default_prog = { "/bin/zsh", "-l" }
  config.font_size = 16
end
config.exit_behavior = "CloseOnCleanExit"
config.status_update_interval = 1000
config.colors = {
  scrollbar_thumb = "white",
}
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Hack Nerd Font Mono",
  "Hiragino Sans",
  "Noto Sans JP",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.8
config.macos_window_background_blur = 30
config.win32_system_backdrop = "Acrylic"
-- config.macos_window_dragging_behavior = "all"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_gradient = {
  orientation = "Vertical",
  colors = {
    -- "#0f0c29",
    -- "#302b63",
    -- "#24243e",
    "#000000",
    "#111111",
  },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 64,
}

return config
