local wezterm = require("wezterm")
local utils = require("utils")

local TAB_MAX_WIDTH = 16
local ACTIVE_FG = "#ffffff"
local INACTIVE_FG = "#888888"

-- Display width of a string that may end with "…"
-- ("…" is 3 bytes in UTF-8 but 1 display column)
local function display_width(str)
  if string.sub(str, -3) == "…" then
    return #str - 2
  end
  return #str
end

wezterm.on("format-window-title", function(tab)
  return utils.basename(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane

  -- "[n]" prefix for tabs reachable with a single digit
  local index = tab.tab_index + 1
  local prefix = index <= 9 and "[" .. tostring(index) .. "]" or ""

  -- Project name, falling back to the running process, padded to a fixed width
  local available = TAB_MAX_WIDTH - 2 - #prefix
  local title = utils.get_project_name(utils.get_cwd(pane)) or utils.basename(pane.foreground_process_name)
  title = utils.truncate(title, available)
  local padding = string.rep(" ", math.max(available - display_width(title), 0))

  return {
    { Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
    { Foreground = { Color = tab.is_active and ACTIVE_FG or INACTIVE_FG } },
    { Background = { Color = "none" } },
    { Text = " " .. prefix .. title .. padding .. " " },
  }
end)
