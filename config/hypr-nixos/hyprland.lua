-- Hyprland on NixOS (siraken-mba), without Omarchy.
--
-- Lives in ~/.config/hypr-nixos rather than ~/.config/hypr: until Omarchy is
-- removed from the MacBook Air, both systems share /home, and ~/.config/hypr is
-- still Omarchy's (config/hypr). NixOS points Hyprland here with
-- HYPRLAND_CONFIG. Ported from Omarchy's defaults
-- (/usr/share/omarchy/default/hypr), keeping only what is used.

local home = os.getenv("HOME")

-- Drop the modules loaded by the previous run so `hyprctl reload` picks up
-- edits to them.
for module in pairs(package.loaded) do
  if module:match("^hypr%-nixos%.") then
    package.loaded[module] = nil
  end
end

package.path = home .. "/.config/?.lua;" .. package.path

require("hypr-nixos.lib")

require("hypr-nixos.envs")
require("hypr-nixos.monitors")
require("hypr-nixos.input")
require("hypr-nixos.looknfeel")
require("hypr-nixos.windows")
require("hypr-nixos.bindings")
require("hypr-nixos.autostart")
