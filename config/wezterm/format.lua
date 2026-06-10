local wezterm = require("wezterm")
local utils = require("utils")

local TAB_MAX_WIDTH = 16

wezterm.on("format-window-title", function(tab)
  return utils.basename(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab)
  local fg = tab.is_active and "#ffffff" or "#888888"
  local intensity = tab.is_active and "Bold" or "Normal"

  local index = tab.tab_index + 1
  local prefix = index <= 9 and "[" .. tostring(index) .. "]" or ""

  local cwd = utils.get_cwd(tab.active_pane)
  local title = utils.get_project_name(cwd) or utils.basename(tab.active_pane.foreground_process_name)

  local available = TAB_MAX_WIDTH - 2 - #prefix
  title = utils.truncate(title, available)

  -- "…" is 3 bytes UTF-8 but 1 display column
  local has_ellipsis = string.sub(title, -3) == "…"
  local display_width = has_ellipsis and (#title - 2) or #title
  local pad = available - display_width
  local padding = pad > 0 and string.rep(" ", pad) or ""

  return {
    { Attribute = { Intensity = intensity } },
    { Foreground = { Color = fg } },
    { Background = { Color = "none" } },
    { Text = " " .. prefix .. title .. padding .. " " },
  }
end)
