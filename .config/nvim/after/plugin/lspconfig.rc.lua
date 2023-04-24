-- NeoVim LSP Config
local nvim_lsp__status, nvim_lsp = pcall(require, 'lspconfig')
if (not nvim_lsp__status) then return end

local root_pattern = nvim_lsp.util.root_pattern

-- Mason Config
local mason__status, mason = pcall(require, 'mason')
if (not mason__status) then return end

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

-- Mason LSP Config
local mason_lsp__status, mason_lsp = pcall(require, 'mason-lspconfig')
if (not mason_lsp__status) then return end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Server configuration docs:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

mason_lsp.setup {
  automatic_installation = false,
}

mason_lsp.setup_handlers {
  function(server_name)
    local opts = {}

    -- lua_ls: Lua
    if server_name == 'lua_ls' then
      opts.settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
          }
        }
      }
    end

    -- denols: Deno
    if server_name == 'denols' then
      opts.on_attach = on_attach
      opts.root_dir = root_pattern('deno.json', 'deno.jsonc')
    end

    -- tsserver: JavaScript / TypeScript
    if server_name == 'tsserver' then
      opts.on_attach = on_attach
      -- opts.single_file_support = false
    end

    -- tailwindcss: TailwindCSS
    if server_name == 'tailwindcss' then
      opts.settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "classList", "ngClass" },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning"
          },
          validate = true
        }
      }
    end

    -- rust_analyzer: Rust
    if server_name == 'rust_analyzer' then
      opts.cmd = { 'rust-analyzer' }
      opts.filetypes = {
        'rust',
      }
      opts.settings = {
        ['rust-analyzer'] = {}
      }
    end

    -- ccls: C/C++
    if server_name == 'ccls' then
      opts.cmd = { 'ccls' }
      opts.filetypes = {
        'c',
        'cpp',
        'objc',
        'objcpp',
      }
    end

    -- omnisharp: C#
    -- if server_name == 'omnisharp' then
    --   opts.cmd = { "dotnet", "/path/to/omnisharp/Omnisharp.dll" }
    -- end

    -- powershell_es: PowerShell
    -- if server_name == 'powershell_es' then
    --   opts.filetypes = { 'powershell' }
    --   opts.root_dir = root_pattern('*.ps1', '*.psd1', '*.psm1', '.git')
    -- end

    -- sourcekit: Swift
    -- if server_name == 'sourcekit' then
    --   opts.cmd = { 'sourcekit-lsp' }
    --   opts.root_dir = root_pattern('Package.swift', '.git')
    -- end

    nvim_lsp[server_name].setup(opts)
  end
}
