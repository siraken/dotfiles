local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")
local spotify_controls = require("spotify-controls")

-- Modifier sets shared by many bindings. Shifted keys ("C", "!") arrive with
-- or without SHIFT in mods; unshifted ones ("c", "1") are also bound on SUPER.
local CTRL_SHIFTED = { "CTRL", "SHIFT|CTRL" }
local CTRL_SHIFT_OR_SUPER = { "SHIFT|CTRL", "SUPER" }
local SHIFTED = { "NONE", "SHIFT" }

-- Windows reserves nearly every Win-key shortcut (Win+L, Win+V, Win+1..9,
-- Win+Shift+S, ...), and the Cmd+Shift Spotify controls call osascript, so
-- bindings on SUPER / CMD are only registered off Windows.
local function is_available(mods)
  return not (utils.is_windows and (mods:find("SUPER") or mods:find("CMD")))
end

-- Expand { key, mods, action } specs into WezTerm key entries. `mods` may be a
-- list, in which case the same action is bound once per modifier combination.
local function bindings(...)
  local result = {}
  for _, specs in ipairs({ ... }) do
    for _, spec in ipairs(specs) do
      local key, mods, action = spec[1], spec[2], spec[3]
      for _, m in ipairs(type(mods) == "table" and mods or { mods }) do
        if is_available(m) then
          table.insert(result, { key = key, mods = m, action = action })
        end
      end
    end
  end
  return result
end

-- Ctrl+Shift+<n> / Super+<n> activate tab n ("9" is the last tab). The shifted
-- symbols are listed too because some layouts report them instead of digits.
local function tab_activation()
  local specs = {}
  local tabs = {
    { "1", "!", 0 },
    { "2", "@", 1 },
    { "3", "#", 2 },
    { "4", "$", 3 },
    { "5", "%", 4 },
    { "6", "^", 5 },
    { "7", "&", 6 },
    { "8", "*", 7 },
    { "9", "(", -1 },
  }
  for _, tab in ipairs(tabs) do
    local digit, symbol, index = tab[1], tab[2], tab[3]
    table.insert(specs, { digit, CTRL_SHIFT_OR_SUPER, act.ActivateTab(index) })
    table.insert(specs, { symbol, CTRL_SHIFTED, act.ActivateTab(index) })
  end
  return specs
end

local split_vertical = act.SplitVertical({ domain = "CurrentPaneDomain" })
local split_horizontal = act.SplitHorizontal({ domain = "CurrentPaneDomain" })
local char_select = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" })
local search = act.Search("CurrentSelectionOrEmptyString")
local clear_scrollback = act.ClearScrollback("ScrollbackOnly")

local tabs = {
  { "Tab", "CTRL", act.ActivateTabRelative(1) },
  { "Tab", "SHIFT|CTRL", act.ActivateTabRelative(-1) },
  { "PageUp", "CTRL", act.ActivateTabRelative(-1) },
  { "PageDown", "CTRL", act.ActivateTabRelative(1) },
  { "[", "SHIFT|SUPER", act.ActivateTabRelative(-1) },
  { "]", "SHIFT|SUPER", act.ActivateTabRelative(1) },
  { "{", { "SUPER", "SHIFT|SUPER" }, act.ActivateTabRelative(-1) },
  { "}", { "SUPER", "SHIFT|SUPER" }, act.ActivateTabRelative(1) },
  { "PageUp", "SHIFT|CTRL", act.MoveTabRelative(-1) },
  { "PageDown", "SHIFT|CTRL", act.MoveTabRelative(1) },
  { "T", CTRL_SHIFTED, act.SpawnTab("CurrentPaneDomain") },
  { "t", CTRL_SHIFT_OR_SUPER, act.SpawnTab("CurrentPaneDomain") },
  { "W", CTRL_SHIFTED, act.CloseCurrentTab({ confirm = true }) },
  { "w", CTRL_SHIFT_OR_SUPER, act.CloseCurrentTab({ confirm = true }) },
}

local panes = {
  { '"', { "ALT|CTRL", "SHIFT|ALT|CTRL" }, split_vertical },
  { "'", "SHIFT|ALT|CTRL", split_vertical },
  { "D", "ALT", split_vertical },
  { "%", { "ALT|CTRL", "SHIFT|ALT|CTRL" }, split_horizontal },
  { "5", "SHIFT|ALT|CTRL", split_horizontal },
  { "d", "ALT", split_horizontal },
  { "Z", CTRL_SHIFTED, act.TogglePaneZoomState },
  { "z", "SHIFT|CTRL", act.TogglePaneZoomState },
  { "h", "LEADER", act.ActivatePaneDirection("Left") },
  { "j", "LEADER", act.ActivatePaneDirection("Down") },
  { "k", "LEADER", act.ActivatePaneDirection("Up") },
  { "l", "LEADER", act.ActivatePaneDirection("Right") },
}

local window = {
  { "Enter", "ALT", act.ToggleFullScreen },
  { "F", "ALT", act.ToggleFullScreen },
  { "N", CTRL_SHIFTED, act.SpawnWindow },
  { "n", CTRL_SHIFT_OR_SUPER, act.SpawnWindow },
  { "M", CTRL_SHIFTED, act.Hide },
  { "m", CTRL_SHIFT_OR_SUPER, act.Hide },
  { "H", CTRL_SHIFTED, act.HideApplication },
  { "h", CTRL_SHIFT_OR_SUPER, act.HideApplication },
  { "Q", CTRL_SHIFTED, act.QuitApplication },
  { "q", CTRL_SHIFT_OR_SUPER, act.QuitApplication },
  { "R", CTRL_SHIFTED, act.ReloadConfiguration },
  { "r", CTRL_SHIFT_OR_SUPER, act.ReloadConfiguration },
  -- Toggle background transparency (peek behind window)
  { "b", "CMD|SHIFT", wezterm.action_callback(utils.toggle_transparency) },
}

local font_size = {
  { "+", CTRL_SHIFTED, act.IncreaseFontSize },
  { "=", { "CTRL", "SHIFT|CTRL", "SUPER" }, act.IncreaseFontSize },
  { "-", { "CTRL", "SHIFT|CTRL", "SUPER" }, act.DecreaseFontSize },
  { "_", CTRL_SHIFTED, act.DecreaseFontSize },
  { ")", CTRL_SHIFTED, act.ResetFontSize },
  { "0", { "CTRL", "SHIFT|CTRL", "SUPER" }, act.ResetFontSize },
}

local clipboard = {
  { "C", CTRL_SHIFTED, act.CopyTo("Clipboard") },
  { "c", CTRL_SHIFT_OR_SUPER, act.CopyTo("Clipboard") },
  { "Copy", "NONE", act.CopyTo("Clipboard") },
  { "V", CTRL_SHIFTED, act.PasteFrom("Clipboard") },
  { "v", CTRL_SHIFT_OR_SUPER, act.PasteFrom("Clipboard") },
  { "Paste", "NONE", act.PasteFrom("Clipboard") },
}

local scrollback = {
  { "PageUp", "SHIFT", act.ScrollByPage(-1) },
  { "PageDown", "SHIFT", act.ScrollByPage(1) },
  { "K", CTRL_SHIFTED, clear_scrollback },
  { "k", CTRL_SHIFT_OR_SUPER, clear_scrollback },
  { "F", CTRL_SHIFTED, search },
  { "f", CTRL_SHIFT_OR_SUPER, search },
  { "X", CTRL_SHIFTED, act.ActivateCopyMode },
  { "x", "SHIFT|CTRL", act.ActivateCopyMode },
  { "phys:Space", "SHIFT|CTRL", act.QuickSelect },
}

local tools = {
  { "P", CTRL_SHIFTED, act.ActivateCommandPalette },
  { "p", "SHIFT|CTRL", act.ActivateCommandPalette },
  { "L", CTRL_SHIFTED, act.ShowDebugOverlay },
  { "l", "SHIFT|CTRL", act.ShowDebugOverlay },
  { "l", "ALT", act.ShowLauncher },
  { "U", CTRL_SHIFTED, char_select },
  { "u", "SHIFT|CTRL", char_select },
}

local input = {
  { "Enter", "SHIFT", act.SendString("\n") },
}

-- Spotify controls (Cmd+Shift+<key>)
local spotify = {
  { "s", "CMD|SHIFT", wezterm.action_callback(spotify_controls.play_pause) },
  { "n", "CMD|SHIFT", wezterm.action_callback(spotify_controls.next_track) },
  { "p", "CMD|SHIFT", wezterm.action_callback(spotify_controls.previous_track) },
  { "i", "CMD|SHIFT", wezterm.action_callback(spotify_controls.show_track_info) },
  { "=", "CMD|SHIFT", wezterm.action_callback(spotify_controls.volume_up) },
  { "-", "CMD|SHIFT", wezterm.action_callback(spotify_controls.volume_down) },
}

local copy_mode = {
  -- Exit
  { "Escape", "NONE", act.CopyMode("Close") },
  { "q", "NONE", act.CopyMode("Close") },
  { "c", "CTRL", act.CopyMode("Close") },
  { "g", "CTRL", act.CopyMode("Close") },
  { "y", "NONE", act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }) },

  -- Cursor
  { "h", "NONE", act.CopyMode("MoveLeft") },
  { "j", "NONE", act.CopyMode("MoveDown") },
  { "k", "NONE", act.CopyMode("MoveUp") },
  { "l", "NONE", act.CopyMode("MoveRight") },
  { "LeftArrow", "NONE", act.CopyMode("MoveLeft") },
  { "DownArrow", "NONE", act.CopyMode("MoveDown") },
  { "UpArrow", "NONE", act.CopyMode("MoveUp") },
  { "RightArrow", "NONE", act.CopyMode("MoveRight") },

  -- Words
  { "w", "NONE", act.CopyMode("MoveForwardWord") },
  { "b", "NONE", act.CopyMode("MoveBackwardWord") },
  { "e", "NONE", act.CopyMode("MoveForwardWordEnd") },
  { "Tab", "NONE", act.CopyMode("MoveForwardWord") },
  { "Tab", "SHIFT", act.CopyMode("MoveBackwardWord") },
  { "f", "ALT", act.CopyMode("MoveForwardWord") },
  { "b", "ALT", act.CopyMode("MoveBackwardWord") },
  { "RightArrow", "ALT", act.CopyMode("MoveForwardWord") },
  { "LeftArrow", "ALT", act.CopyMode("MoveBackwardWord") },

  -- Lines
  { "0", "NONE", act.CopyMode("MoveToStartOfLine") },
  { "Home", "NONE", act.CopyMode("MoveToStartOfLine") },
  { "^", SHIFTED, act.CopyMode("MoveToStartOfLineContent") },
  { "m", "ALT", act.CopyMode("MoveToStartOfLineContent") },
  { "$", SHIFTED, act.CopyMode("MoveToEndOfLineContent") },
  { "End", "NONE", act.CopyMode("MoveToEndOfLineContent") },
  { "Enter", "NONE", act.CopyMode("MoveToStartOfNextLine") },

  -- Viewport / scrollback
  { "H", SHIFTED, act.CopyMode("MoveToViewportTop") },
  { "M", SHIFTED, act.CopyMode("MoveToViewportMiddle") },
  { "L", SHIFTED, act.CopyMode("MoveToViewportBottom") },
  { "g", "NONE", act.CopyMode("MoveToScrollbackTop") },
  { "G", SHIFTED, act.CopyMode("MoveToScrollbackBottom") },
  { "PageUp", "NONE", act.CopyMode("PageUp") },
  { "PageDown", "NONE", act.CopyMode("PageDown") },
  { "b", "CTRL", act.CopyMode("PageUp") },
  { "f", "CTRL", act.CopyMode("PageDown") },
  { "u", "CTRL", act.CopyMode({ MoveByPage = -0.5 }) },
  { "d", "CTRL", act.CopyMode({ MoveByPage = 0.5 }) },

  -- Jump to character
  { "f", "NONE", act.CopyMode({ JumpForward = { prev_char = false } }) },
  { "t", "NONE", act.CopyMode({ JumpForward = { prev_char = true } }) },
  { "F", SHIFTED, act.CopyMode({ JumpBackward = { prev_char = false } }) },
  { "T", SHIFTED, act.CopyMode({ JumpBackward = { prev_char = true } }) },
  { ";", "NONE", act.CopyMode("JumpAgain") },
  { ",", "NONE", act.CopyMode("JumpReverse") },

  -- Selection
  { "Space", "NONE", act.CopyMode({ SetSelectionMode = "Cell" }) },
  { "v", "NONE", act.CopyMode({ SetSelectionMode = "Cell" }) },
  { "V", SHIFTED, act.CopyMode({ SetSelectionMode = "Line" }) },
  { "v", "CTRL", act.CopyMode({ SetSelectionMode = "Block" }) },
  { "o", "NONE", act.CopyMode("MoveToSelectionOtherEnd") },
  { "O", SHIFTED, act.CopyMode("MoveToSelectionOtherEndHoriz") },
}

local search_mode = {
  { "Escape", "NONE", act.CopyMode("Close") },
  { "Enter", "NONE", act.CopyMode("PriorMatch") },
  { "UpArrow", "NONE", act.CopyMode("PriorMatch") },
  { "DownArrow", "NONE", act.CopyMode("NextMatch") },
  { "p", "CTRL", act.CopyMode("PriorMatch") },
  { "n", "CTRL", act.CopyMode("NextMatch") },
  { "PageUp", "NONE", act.CopyMode("PriorMatchPage") },
  { "PageDown", "NONE", act.CopyMode("NextMatchPage") },
  { "r", "CTRL", act.CopyMode("CycleMatchType") },
  { "u", "CTRL", act.CopyMode("ClearPattern") },
}

return {
  keys = bindings(tabs, tab_activation(), panes, window, font_size, clipboard, scrollback, tools, input, spotify),
  key_tables = {
    copy_mode = bindings(copy_mode),
    search_mode = bindings(search_mode),
  },
}
