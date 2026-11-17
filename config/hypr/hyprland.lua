-- Hyprland on NixOS (siraken-mba). Ported from Omarchy's defaults
-- (/usr/share/omarchy/default/hypr), keeping only what is used.

local home = os.getenv("HOME")

-- Drop the modules loaded by the previous run so `hyprctl reload` picks up
-- edits to them.
for module in pairs(package.loaded) do
  if module:match("^hypr%.") then
    package.loaded[module] = nil
  end
end

package.path = home .. "/.config/?.lua;" .. package.path

require("hypr.lib")

require("hypr.envs")
require("hypr.monitors")
require("hypr.input")
require("hypr.looknfeel")
require("hypr.windows")
require("hypr.bindings")
require("hypr.autostart")
