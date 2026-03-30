local wezterm = require("wezterm")
local utils = require("utils")

local DPI_CHANGE_NUM = 140
local DPI_CHANGE_FONT_SIZE = 16.0

local prev_dpi = 0

wezterm.on("window-focus-changed", function(window, pane)
  local dpi = window:get_dimensions().dpi

  if dpi == prev_dpi then
    return
  end

  local overrides = window:get_config_overrides() or {}
  overrides.font_size = dpi >= DPI_CHANGE_NUM and DPI_CHANGE_FONT_SIZE or nil

  window:set_config_overrides(overrides)

  prev_dpi = dpi
end)

wezterm.on("augment-command-palette", function(window, pane)
  return {
    {
      brief = "Toggle Background Transparency",
      icon = "md_circle_opacity",
      action = wezterm.action_callback(function(win, p)
        utils.toggle_transparency(win)
      end),
    },
    {
      brief = "Set Fully Opaque Background",
      icon = "md_circle",
      action = wezterm.action_callback(function(win, p)
        utils.set_opaque(win)
      end),
    },
  }
end)
