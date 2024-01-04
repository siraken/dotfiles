-- Configuration
-- https://wezfurlong.org/wezterm/config/files.html
local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
config.font_size = 16
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Hack Nerd Font Mono",
  "Fira Code",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.window_background_opacity = 0.95
config.default_cwd = "$HOME/repos"

return config
