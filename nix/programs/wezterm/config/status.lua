local wezterm = require("wezterm")
local colors = require("colors")
local utils = require("utils")

-- Left
local function UpdateLeft(window, pane)
  local elems = {}
  window:set_left_status(wezterm.format(elems))
end

-- Right
local function UpdateRight(window, pane)
  local elems = {}

  local cwd = utils.get_cwd(pane)
  local project = utils.get_project_name(cwd)
  local branch = utils.get_git_branch(cwd)

  -- Project name (max 20 chars)
  if project then
    utils.add_element(
      elems,
      { Foreground = { Color = colors.TOKYO_NIGHT_BLUE.Color }, Text = wezterm.nerdfonts.md_folder },
      utils.truncate(project, 20)
    )
  end

  -- Git branch (max 24 chars)
  if branch then
    utils.add_element(
      elems,
      { Foreground = { Color = colors.TOKYO_NIGHT_PURPLE.Color }, Text = wezterm.nerdfonts.dev_git_branch },
      utils.truncate(branch, 24)
    )
  end

  -- Full screen only: Spotify status, Battery
  if window:get_dimensions().is_full_screen then
    local spotify_info = require("spotify").get_status_element()
    if spotify_info then
      utils.add_element(
        elems,
        { Foreground = { Color = spotify_info.color }, Text = spotify_info.icon },
        spotify_info.text
      )
    end

    for _, b in ipairs(wezterm.battery_info()) do
      utils.add_element(
        elems,
        { Foreground = { Color = colors.YELLOW.Color }, Text = "" },
        string.format("%.0f%%", b.state_of_charge * 100)
      )
    end
  end

  window:set_right_status(wezterm.format(elems))
end

wezterm.on("update-status", function(window, pane)
  UpdateLeft(window, pane)
  UpdateRight(window, pane)
end)
