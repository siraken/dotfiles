local wezterm = require("wezterm")
local act = wezterm.action

local is_mac = string.find(wezterm.target_triple, "apple")
local link_mods = is_mac and "SUPER" or "CTRL"

return {
  -- macOS: Cmd+Click / other: Ctrl+Click でリンクを開く
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = link_mods,
    action = act.OpenLinkAtMouseCursor,
  },
  -- 修飾キーなしクリックではリンクを開かない（デフォルト動作を上書き）
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
}
