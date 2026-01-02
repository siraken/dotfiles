local wezterm = require("wezterm")
local colors = require("colors")

local M = {}

local DEFAULT_FG = colors.DEFAULT_FG
local DEFAULT_BG = colors.TRANSPARENT

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

-- Get project name (git repository root directory name)
function M.get_project_name(cwd)
  if not cwd then
    return nil
  end

  local success, stdout, stderr = wezterm.run_child_process({
    "git",
    "-C",
    cwd,
    "rev-parse",
    "--show-toplevel",
  })

  if success then
    local path = stdout:gsub("%s+", "")
    -- Extract directory name from path
    return path:match("([^/]+)$")
  end
  return nil
end

-- Get current working directory from pane
function M.get_cwd(pane)
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
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

return M
