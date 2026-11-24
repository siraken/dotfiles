local wezterm = require("wezterm")
local colors = require("colors")

local M = {}

M.is_darwin = string.find(wezterm.target_triple, "apple") ~= nil
M.is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

local DEFAULT_FG = colors.DEFAULT_FG
local DEFAULT_BG = colors.TRANSPARENT

-- Strings ----------------------------------------------------------------

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

-- Git --------------------------------------------------------------------

-- On Windows the panes live in WSL, so their cwd is a Linux path that the
-- Windows side cannot open directly. Skip the lookups there.

local GIT_REPO_CACHE_TTL = 10
local GIT_REPO_CACHE_MAX = 128

-- Bounded TTL cache: cwd -> { repo = { name, git_dir } | false, expires_at = timestamp }
local git_repo_cache = {}
local git_repo_cache_size = 0

local function parent_dir(path)
  if path == "/" or not path:match("^/") then
    return nil
  end
  return path:match("^(.+)/[^/]+$") or "/"
end

-- Resolve the .git directory for a candidate repository root without spawning
-- git. Supports both regular repositories (.git/HEAD) and worktrees/submodules
-- (.git file containing "gitdir: <path>").
local function resolve_git_dir(dir)
  local dot_git = dir == "/" and "/.git" or (dir .. "/.git")

  local head = io.open(dot_git .. "/HEAD", "r")
  if head then
    head:close()
    return dot_git
  end

  local file = io.open(dot_git, "r")
  if not file then
    return nil
  end
  local line = file:read("*l")
  file:close()
  if not line then
    return nil
  end

  local gitdir = line:match("^gitdir:%s*(.-)%s*$")
  if not gitdir or gitdir == "" then
    return nil
  end
  if not gitdir:match("^/") then
    gitdir = dir == "/" and ("/" .. gitdir) or (dir .. "/" .. gitdir)
  end

  local wt_head = io.open(gitdir .. "/HEAD", "r")
  if not wt_head then
    return nil
  end
  wt_head:close()
  return gitdir
end

local function find_git_repo(cwd)
  if not cwd or cwd == "" or M.is_windows then
    return nil
  end

  local now = os.time()
  local cached = git_repo_cache[cwd]
  if cached and now < cached.expires_at then
    return cached.repo or nil
  end

  local dir = cwd:gsub("/+$", "")
  if dir == "" then
    dir = "/"
  end

  local repo = nil
  while dir do
    local git_dir = resolve_git_dir(dir)
    if git_dir then
      repo = {
        name = dir:match("([^/]+)$"),
        git_dir = git_dir,
      }
      break
    end
    dir = parent_dir(dir)
  end

  if git_repo_cache[cwd] == nil then
    if git_repo_cache_size >= GIT_REPO_CACHE_MAX then
      git_repo_cache = {}
      git_repo_cache_size = 0
    end
    git_repo_cache_size = git_repo_cache_size + 1
  end
  git_repo_cache[cwd] = {
    repo = repo or false,
    expires_at = now + GIT_REPO_CACHE_TTL,
  }

  return repo
end

local function read_git_head(git_dir)
  local file = io.open(git_dir .. "/HEAD", "r")
  if not file then
    return nil
  end
  local line = file:read("*l")
  file:close()
  if not line then
    return nil
  end

  line = line:match("^%s*(.-)%s*$")
  local branch = line:match("^ref:%s*refs/heads/(.+)$")
  if branch then
    return branch
  end
  local ref = line:match("^ref:%s*(.+)$")
  if ref then
    return ref
  end
  if line:match("^[0-9a-fA-F]+$") then
    return line:sub(1, 7)
  end
  return nil
end

-- Get git branch name for the given directory
function M.get_git_branch(cwd)
  local repo = find_git_repo(cwd)
  if not repo then
    return nil
  end

  local branch = read_git_head(repo.git_dir)
  if not branch and git_repo_cache[cwd] ~= nil then
    git_repo_cache[cwd] = nil
    git_repo_cache_size = math.max(git_repo_cache_size - 1, 0)
  end
  return branch
end

-- Get project name (git repository root directory name, with cache)
function M.get_project_name(cwd)
  local repo = find_git_repo(cwd)
  return repo and repo.name or nil
end

-- Panes ------------------------------------------------------------------

-- Get current working directory from pane (supports both Pane and PaneInformation).
-- Both are userdata that raise on unknown keys: a Pane has the method, a
-- PaneInformation (format-tab-title) only the field, so try them separately.
function M.get_cwd(pane)
  local ok, cwd_uri = pcall(function()
    return pane:get_current_working_dir()
  end)
  if not ok then
    ok, cwd_uri = pcall(function()
      return pane.current_working_dir
    end)
  end

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

-- Status bar -------------------------------------------------------------

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

-- Window overrides -------------------------------------------------------

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
