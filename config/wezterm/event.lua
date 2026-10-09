local wezterm = require("wezterm")
local utils = require("utils")

-- On a high-DPI display (dpi >= threshold) override the font size; otherwise
-- drop the override and fall back to the configured size.
local HIGH_DPI_THRESHOLD = 140
local HIGH_DPI_FONT_SIZE = 16.0

local prev_dpi = 0

wezterm.on("window-focus-changed", function(window, _pane)
  local dpi = window:get_dimensions().dpi
  if dpi == prev_dpi then
    return
  end

  local overrides = window:get_config_overrides() or {}
  overrides.font_size = dpi >= HIGH_DPI_THRESHOLD and HIGH_DPI_FONT_SIZE or nil
  window:set_config_overrides(overrides)

  prev_dpi = dpi
end)

wezterm.on("augment-command-palette", function(_window, _pane)
  return {
    {
      brief = "Toggle Background Transparency",
      icon = "md_circle_opacity",
      action = wezterm.action_callback(utils.toggle_transparency),
    },
    {
      brief = "Set Fully Opaque Background",
      icon = "md_circle_slice_8",
      action = wezterm.action_callback(utils.set_opaque),
    },
  }
end)
