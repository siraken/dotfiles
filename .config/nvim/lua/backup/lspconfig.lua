-- NeoVim LSP Config
-- https://github.com/neovim/nvim-lspconfig
-- Mason Config
-- https://github.com/williamboman/mason.nvim
-- Mason LSP Config
-- https://github.com/williamboman/mason-lspconfig.nvim
-- Neovim LSP
return {
  -- "neovim/nvim-lspconfig"
}
-- Mason: LSP client for Neovim
-- return { "williamboman/mason.nvim" }
-- return { "williamboman/mason-lspconfig.nvim" }

-- local status1, nvim_lsp = pcall(require, 'lspconfig')
-- local status2, mason = pcall(require, 'mason')
-- local status3, mason_lsp = pcall(require, 'mason-lspconfig')
-- if (not status1) then return end
-- if (not status2) then return end
-- if (not status3) then return end
--
-- local root_pattern = nvim_lsp.util.root_pattern
--
-- mason.setup {
--   ui = {
--     icons = {
--       package_installed = "",
--       package_pending = "",
--       package_uninstalled = ""
--       -- package_installed = "✓",
--       -- package_pending = "➜",
--       -- package_uninstalled = "✗"
--     }
--   },
--   ensure_installed = {
--     'prettier'
--   }
-- }
--
-- -- Server configuration docs:
-- -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
--
-- mason_lsp.setup {
--   automatic_installation = true,
--   -- ensure_installed = {
--   -- }
-- }
--
-- mason_lsp.setup_handlers {
--   function(server_name)
--     local opts = {}
--
--     -- Lua
--     if server_name == 'lua_ls' then
--       opts.settings = {
--         Lua = {
--           runtime = {
--             version = 'LuaJIT'
--           },
--           diagnostics = {
--             globals = { 'vim' }
--           },
--           workspace = {
--             library = vim.api.nvim_get_runtime_file('', true)
--           }
--         }
--       }
--     end
--
--     -- Deno
--     if server_name == 'denols' then
--       opts.root_dir = root_pattern('deno.json', 'deno.jsonc')
--     end
--
--     -- JavaScript / TypeScript
--     if server_name == 'tsserver' then
--       opts.single_file_support = true
--     end
--
--     -- TailwindCSS
--     if server_name == 'tailwindcss' then
--       opts.settings = {
--         tailwindCSS = {
--           classAttributes = { "class", "className", "classList", "ngClass" },
--           lint = {
--             cssConflict = "warning",
--             invalidApply = "error",
--             invalidConfigPath = "error",
--             invalidScreen = "error",
--             invalidTailwindDirective = "error",
--             invalidVariant = "error",
--             recommendedVariantOrder = "warning"
--           },
--           validate = true
--         }
--       }
--     end
--
--     -- Rust
--     if server_name == 'rust_analyzer' then
--       opts.cmd = { 'rust-analyzer' }
--       opts.filetypes = {
--         'rust',
--       }
--       opts.settings = {
--         ['rust-analyzer'] = {}
--       }
--     end
--
--     -- Solargraph
--     if server_name == 'solargraph' then
--       opts.settings = {
--         transport = 'external',
--         externalServer = {
--           host = 'localhost',
--           port = 7658
--         }
--       }
--     end
--
--     -- C/C++
--     if server_name == 'ccls' then
--       opts.cmd = { 'ccls' }
--       opts.filetypes = {
--         'c',
--         'cpp',
--         'objc',
--         'objcpp',
--       }
--     end
--
--     -- Avoid "Multiple different client offset_encodings detected"
--     if server_name == 'clangd' then
--       opts.cmd = {
--         'clangd',
--         '--offset-encoding=utf-16'
--       }
--     end
--
--     -- C#
--     -- if server_name == 'omnisharp' then
--     --   opts.cmd = { "dotnet", "/path/to/omnisharp/Omnisharp.dll" }
--     -- end
--
--     -- PowerShell
--     -- if server_name == 'powershell_es' then
--     --   opts.filetypes = { 'powershell' }
--     --   opts.root_dir = root_pattern('*.ps1', '*.psd1', '*.psm1', '.git')
--     -- end
--
--     -- Swift
--     -- if server_name == 'sourcekit' then
--     --   opts.cmd = { 'sourcekit-lsp' }
--     --   opts.root_dir = root_pattern('Package.swift', '.git')
--     -- end
--
--     nvim_lsp[server_name].setup(opts)
--   end
-- }
