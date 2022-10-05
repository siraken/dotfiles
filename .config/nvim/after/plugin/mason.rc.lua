local status, mason = pcall(require, 'mason')
if (not status) then return end

local status2, mlsp = pcall(require, 'mason-lspconfig')
if (not status2) then return end

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

mlsp.setup {
  ensure_installed = {}
}
