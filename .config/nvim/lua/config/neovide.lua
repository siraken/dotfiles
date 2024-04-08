local g = vim.g
local o = vim.o

local alpha = function()
  return string.format("%x", math.floor(255 * g.transparency or 0.8))
end

if g.neovide then
  g.neovide_transparency = 0.5
  g.transparency = 0.8
  g.neovide_background_color = "#0f1117" .. alpha()
  g.neovide_window_blurred = true
  g.neovide_floating_shadow = true
  g.neovide_light_radius = 5
end
