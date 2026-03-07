local wezterm = require("wezterm")

local TAB_MAX_WIDTH = 16

local function BaseName(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function Truncate(s, max)
  if max <= 0 then
    return ""
  end
  if #s > max then
    return string.sub(s, 1, max - 1) .. "…"
  end
  return s
end

local function GetClaudeStatus(pane)
  local tmpdir = os.getenv("TMPDIR") or "/tmp/"
  local f = io.open(tmpdir .. "wezterm-claude-status-" .. tostring(pane.pane_id))
  if not f then
    return nil
  end
  local status = f:read("*l")
  f:close()
  return status
end

local git_repo_cache = {}

local function GetRepoName(pane)
  local ok, cwd_url = pcall(function()
    return pane.current_working_dir
  end)
  if not ok or not cwd_url then
    return nil
  end

  -- current_working_dir can be a Url object or a string depending on version
  local cwd
  if type(cwd_url) == "string" then
    cwd = cwd_url:gsub("^file://[^/]*", "")
  elseif cwd_url.file_path then
    cwd = cwd_url.file_path
  else
    return nil
  end

  if not cwd or cwd == "" then
    return nil
  end

  local cached = git_repo_cache[cwd]
  if cached ~= nil then
    return cached or nil
  end

  local child_ok, child_result = pcall(function()
    local s, out = wezterm.run_child_process({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
    if s and out then
      return out:gsub("%s+$", "")
    end
    return nil
  end)

  if child_ok and child_result then
    local repo_name = BaseName(child_result)
    git_repo_cache[cwd] = repo_name
    return repo_name
  end

  git_repo_cache[cwd] = false
  return nil
end

wezterm.on("format-window-title", function(tab)
  return BaseName(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab)
  local fg = tab.is_active and "#ffffff" or "#888888"
  local intensity = tab.is_active and "Bold" or "Normal"

  local index = tab.tab_index + 1
  local prefix = index <= 9 and "[" .. tostring(index) .. "]" or ""

  local claude_status = GetClaudeStatus(tab.active_pane)
  local badge = ""
  local badge_fg = nil
  local badge_display_width = 0
  if claude_status == "idle" then
    badge = "● "
    badge_fg = "#9ece6a"
    badge_display_width = 2
  elseif claude_status == "permission" then
    badge = "● "
    badge_fg = "#e0af68"
    badge_display_width = 2
  end

  local title = GetRepoName(tab.active_pane) or BaseName(tab.active_pane.foreground_process_name)

  local available = TAB_MAX_WIDTH - 2 - #prefix - badge_display_width
  title = Truncate(title, available)

  -- "…" is 3 bytes UTF-8 but 1 display column
  local has_ellipsis = string.sub(title, -3) == "…"
  local display_width = has_ellipsis and (#title - 2) or #title
  local pad = available - display_width
  local padding = pad > 0 and string.rep(" ", pad) or ""

  if badge_fg then
    return {
      { Attribute = { Intensity = intensity } },
      { Background = { Color = "none" } },
      { Foreground = { Color = fg } },
      { Text = " " .. prefix },
      { Foreground = { Color = badge_fg } },
      { Text = badge },
      { Foreground = { Color = fg } },
      { Text = title .. padding .. " " },
    }
  end

  return {
    { Attribute = { Intensity = intensity } },
    { Foreground = { Color = fg } },
    { Background = { Color = "none" } },
    { Text = " " .. prefix .. title .. padding .. " " },
  }
end)
