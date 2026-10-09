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

-- Tab label: git project name, falling back to the running process. On Windows
-- every pane's process is wsl.exe (and git lookups are skipped), so use the
-- name of the directory reported by the shell instead.
local function tab_label(pane)
  local cwd = utils.get_cwd(pane)
  local project = utils.get_project_name(cwd)
  if project then
    return project
  end
  if utils.is_windows and cwd then
    local dir = utils.basename(cwd)
    if dir ~= "" then
      return dir
    end
  end
  return utils.basename(pane.foreground_process_name)
end

wezterm.on("format-window-title", function(tab)
  -- Windows shows the title in the OS title bar; wsl.exe tells nothing there,
  -- so keep the title the program in the pane sets (e.g. Claude Code's task).
  if utils.is_windows then
    return tab.active_pane.title
  end
  return utils.basename(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab)
  -- "[n]" prefix for tabs reachable with a single digit
  local index = tab.tab_index + 1
  local prefix = index <= 9 and "[" .. tostring(index) .. "]" or ""

  -- Label padded to a fixed width
  local available = TAB_MAX_WIDTH - 2 - #prefix
  local title = utils.truncate(tab_label(tab.active_pane), available)
  local padding = string.rep(" ", math.max(available - display_width(title), 0))

  return {
    { Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
    { Foreground = { Color = tab.is_active and ACTIVE_FG or INACTIVE_FG } },
    { Background = { Color = "none" } },
    { Text = " " .. prefix .. title .. padding .. " " },
  }
end)
