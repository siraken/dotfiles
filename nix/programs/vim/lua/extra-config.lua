-- Disable clipboard over SSH
if vim.env.SSH_TTY then
  vim.opt.clipboard = ""
end

-- Neovide GUI settings
if vim.g.neovide then
  -- neovide_transparency is now an alias of neovide_opacity, and
  -- neovide_background_color was removed in Neovide 0.16.0.
  vim.g.neovide_opacity = 0.5
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_light_radius = 5
end
