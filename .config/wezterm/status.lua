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

  -- DateTime
  AddElement(
    elems,
    { Foreground = { Color = colors.TOKYO_NIGHT_BLUE.Color }, Text = "󱪺" },
    wezterm.strftime("%b %-d")
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
