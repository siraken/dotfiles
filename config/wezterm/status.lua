local wezterm = require("wezterm")
local colors = require("colors")
local utils = require("utils")

local PROJECT_MAX_LEN = 20
local BRANCH_MAX_LEN = 24

local function update_left_status(window)
  window:set_left_status(wezterm.format({}))
end

local function update_right_status(window, pane)
  local elems = {}

  local cwd = utils.get_cwd(pane)
  local project = utils.get_project_name(cwd)
  local branch = utils.get_git_branch(cwd)

  if window:leader_is_active() then
    table.insert(elems, { Background = colors.TRANSPARENT })
    table.insert(elems, { Foreground = colors.TOKYO_NIGHT_ORANGE })
    table.insert(elems, { Text = "  LEADER " })
  end

  if project then
    utils.add_element(
      elems,
      { Foreground = colors.TOKYO_NIGHT_BLUE, Text = wezterm.nerdfonts.md_folder },
      utils.truncate(project, PROJECT_MAX_LEN)
    )
  end

  if branch then
    utils.add_element(
      elems,
      { Foreground = colors.TOKYO_NIGHT_PURPLE, Text = wezterm.nerdfonts.dev_git_branch },
      utils.truncate(branch, BRANCH_MAX_LEN)
    )
  end

  window:set_right_status(wezterm.format(elems))
end

wezterm.on("update-status", function(window, pane)
  update_left_status(window)
  update_right_status(window, pane)
end)
