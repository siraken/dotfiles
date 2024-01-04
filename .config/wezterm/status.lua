local wezterm = require("wezterm")
local colors = require("colors")

local DEFAULT_FG = colors.DEFAULT_FG
local DEFAULT_BG = colors.DEFAULT_BG

local function AddIcon(elems, icon)
  table.insert(elems, { Foreground = icon.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = " " })
  table.insert(elems, { Text = icon.Text })
  table.insert(elems, { Text = " " })
end

local function GetKeyboard(elems, window)
  local HEADER_LEADER = { Foreground = { Color = colors.WHITE }, Text = "" }
  local HEADER_KEY_NORMAL = { Foreground = DEFAULT_FG, Text = "AB" }
  local HEADER_IME = { Foreground = DEFAULT_FG, Text = "あ" }

  if window:leader_is_active() then
    AddIcon(elems, HEADER_LEADER)
    return
  end

  AddIcon(elems, window:composition_status() and HEADER_IME or HEADER_KEY_NORMAL)
end

local function AddElement(elems, header, str)
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

-- Left
local function UpdateLeft(window, pane)
  local elems = {}

  window:set_left_status(wezterm.format(elems))
end

-- Right
local function UpdateRight(window, pane)
  local elems = {}

  -- Keyboard
  GetKeyboard(elems, window)

  -- DateTime
  AddElement(
    elems,
    { Foreground = { Color = colors.TOKYO_NIGHT_BLUE.Color }, Text = "󱪺" },
    wezterm.strftime("%a %b %-d")
  )
  AddElement(
    elems,
    { Foreground = { Color = colors.TOKYO_NIGHT_GREEN.Color }, Text = "" },
    wezterm.strftime("%H:%M:%S")
  )

  -- Battery (only full screen)
  if window:get_dimensions().is_full_screen then
    for _, b in ipairs(wezterm.battery_info()) do
      AddElement(
        elems,
        { Foreground = { Color = colors.YELLOW.Color }, Text = "" },
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
