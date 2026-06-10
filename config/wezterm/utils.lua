local wezterm = require("wezterm")
local colors = require("colors")

local M = {}

-- Truncate string to max length with ellipsis
function M.truncate(str, max_len)
  if not str or max_len <= 0 then
    return str
  end
  if #str > max_len then
    return str:sub(1, max_len - 1) .. "…"
  end
  return str
end

-- Extract basename from path
function M.basename(s)
  return s:gsub("(.*[/\\])(.*)", "%2")
end

local DEFAULT_FG = colors.DEFAULT_FG
local DEFAULT_BG = colors.TRANSPARENT

-- Cache for git repo lookups (cwd -> repo name or false)
local git_repo_cache = {}

-- Get git branch name for the given directory
function M.get_git_branch(cwd)
  if not cwd then
    return nil
  end

  local success, stdout, stderr = wezterm.run_child_process({
    "git",
    "-C",
    cwd,
    "rev-parse",
    "--abbrev-ref",
    "HEAD",
  })

  if success then
    return stdout:gsub("%s+", "")
  end
  return nil
end

-- Get project name (git repository root directory name, with cache)
function M.get_project_name(cwd)
  if not cwd then
    return nil
  end

  local cached = git_repo_cache[cwd]
  if cached ~= nil then
    return cached or nil
  end

  local success, stdout = wezterm.run_child_process({
    "git",
    "-C",
    cwd,
    "rev-parse",
    "--show-toplevel",
  })

  if success and stdout then
    local path = stdout:gsub("%s+$", "")
    local name = path:match("([^/\\]+)$")
    git_repo_cache[cwd] = name or false
    return name
  end

  git_repo_cache[cwd] = false
  return nil
end

-- Get current working directory from pane (supports both Pane and PaneInformation)
function M.get_cwd(pane)
  local ok, cwd_uri = pcall(function()
    if type(pane.get_current_working_dir) == "function" then
      return pane:get_current_working_dir()
    end
    return pane.current_working_dir
  end)

  if not ok or not cwd_uri then
    return nil
  end

  if type(cwd_uri) == "string" then
    return cwd_uri:gsub("^file://[^/]*", "")
  elseif cwd_uri.file_path then
    return cwd_uri.file_path
  end
  return nil
end

-- Add icon element to status bar
function M.add_icon(elems, icon)
  table.insert(elems, { Foreground = icon.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = " " })
  table.insert(elems, { Text = icon.Text })
  table.insert(elems, { Text = " " })
end

-- Add element with header icon and text to status bar
function M.add_element(elems, header, str)
  -- Space: start
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = " " })

  -- Icon
  table.insert(elems, { Foreground = header.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = header.Text .. " " })

  -- Text
  table.insert(elems, { Foreground = DEFAULT_FG })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = str })

  -- Space: end
  table.insert(elems, { Text = " " })
end

-- Toggle background transparency (peek behind window)
function M.toggle_transparency(window)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_background_opacity then
    overrides.window_background_opacity = nil
    overrides.macos_window_background_blur = nil
  else
    overrides.window_background_opacity = 0.3
    overrides.macos_window_background_blur = 0
  end
  window:set_config_overrides(overrides)
end

-- Set fully opaque background
function M.set_opaque(window)
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_opacity = 1.0
  overrides.macos_window_background_blur = 0
  window:set_config_overrides(overrides)
end

return M
