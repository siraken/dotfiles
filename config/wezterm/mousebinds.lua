local wezterm = require("wezterm")
local act = wezterm.action

local is_darwin = string.find(wezterm.target_triple, "apple") ~= nil
local link_mods = is_darwin and "SUPER" or "CTRL"

local LEFT_CLICK = { Up = { streak = 1, button = "Left" } }
local LEFT_DRAG = { Drag = { streak = 1, button = "Left" } }

return {
  -- macOS: Cmd+Click / other: Ctrl+Click でリンクを開く
  { event = LEFT_CLICK, mods = link_mods, action = act.OpenLinkAtMouseCursor },
  -- 修飾キーなしクリックではリンクを開かない（デフォルト動作を上書き）
  { event = LEFT_CLICK, mods = "NONE", action = act.CompleteSelection("ClipboardAndPrimarySelection") },
  -- Cmd+ドラッグによるウィンドウ移動を無効化
  { event = LEFT_DRAG, mods = link_mods, action = act.DisableDefaultAssignment },
}
