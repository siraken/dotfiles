-- Disable clipboard over SSH
if vim.env.SSH_TTY then
  vim.opt.clipboard = ""
end

-- Neovide GUI settings
if vim.g.neovide then
  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
  end
  vim.g.neovide_transparency = 0.5
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_light_radius = 5
end
