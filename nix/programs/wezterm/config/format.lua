local wezterm = require("wezterm")
local colors = require("colors")

local function BaseName(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-window-title", function(tab)
  return BaseName(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local fg = tab.is_active and "#ffffff" or "#888888"
  local bg = "none"
  local intensity = tab.is_active and "Bold" or "Normal"

  local index = tab.tab_index + 1
  local index_text = index <= 9 and tostring(index) .. ":" or ""

  return {
    { Attribute = { Intensity = intensity } },
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = " " },
    { Text = index_text },
    { Text = BaseName(tab.active_pane.foreground_process_name) },
    { Text = " " },
  }
end)
