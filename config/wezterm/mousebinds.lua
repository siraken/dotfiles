local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

local link_mods = utils.is_darwin and "SUPER" or "CTRL"

local LEFT_CLICK = { Up = { streak = 1, button = "Left" } }
local LEFT_DRAG = { Drag = { streak = 1, button = "Left" } }
local RIGHT_CLICK = { Down = { streak = 1, button = "Right" } }

local bindings = {
  -- macOS: Cmd+Click / other: Ctrl+Click でリンクを開く
  { event = LEFT_CLICK, mods = link_mods, action = act.OpenLinkAtMouseCursor },
  -- 修飾キーなしクリックではリンクを開かない（デフォルト動作を上書き）
  { event = LEFT_CLICK, mods = "NONE", action = act.CompleteSelection("ClipboardAndPrimarySelection") },
  -- Cmd+ドラッグによるウィンドウ移動を無効化
  { event = LEFT_DRAG, mods = link_mods, action = act.DisableDefaultAssignment },
}

if utils.is_windows then
  -- Windows Terminal / conhost と同じく右クリックで貼り付け
  table.insert(bindings, { event = RIGHT_CLICK, mods = "NONE", action = act.PasteFrom("Clipboard") })
end

return bindings
