local wezterm = require("wezterm")
local utils = require("utils")

-- On a high-DPI display (dpi >= threshold) override the font size; otherwise
-- drop the override and fall back to the configured size.
local HIGH_DPI_THRESHOLD = 140
local HIGH_DPI_FONT_SIZE = 16.0

local prev_dpi_by_window = {}

wezterm.on("window-focus-changed", function(window, _pane)
  if not window:is_focused() then
    return
  end

  local win_id = window:window_id()
  local dpi = window:get_dimensions().dpi
  if prev_dpi_by_window[win_id] == dpi then
    return
  end
  prev_dpi_by_window[win_id] = dpi

  local overrides = window:get_config_overrides() or {}
  local target_font_size = dpi >= HIGH_DPI_THRESHOLD and HIGH_DPI_FONT_SIZE or nil
  if target_font_size and overrides.font_size == nil and window:effective_config().font_size == target_font_size then
    return
  end
  if overrides.font_size == target_font_size then
    return
  end

  overrides.font_size = target_font_size
  window:set_config_overrides(overrides)
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
