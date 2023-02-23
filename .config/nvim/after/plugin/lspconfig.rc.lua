-- NeoVim LSP Config
local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local root_pattern = nvim_lsp.util.root_pattern
local api = vim.api

-- Mason LSP Config
local status2, mason_lsp = pcall(require, 'mason-lspconfig')
if (not status2) then return end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    api.nvim_command [[augroup Format]]
    api.nvim_command [[autocmd! * <buffer>]]
    api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    api.nvim_command [[augroup END]]
  end
  -- client.resolved_capabilities.document_formatting = false
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

    -- sumneko_lua: Lua
    if server_name == 'sumneko_lua' then
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

