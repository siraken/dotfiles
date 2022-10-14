local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

tree.setup {
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false, -- Toggle with H
  },
  diagnostics = {
    show_on_dirs = true,
  },
  git = {
    ignore = false,
  }
}
