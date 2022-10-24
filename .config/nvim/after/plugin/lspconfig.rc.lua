local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- Server configuration docs:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- tsserver: JavaScript / TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  cmd = { 'typescript-language-server', '--stdio' }
}

-- denols: Deno
nvim_lsp.denols.setup {}

-- astro: Astro
nvim_lsp.astro.setup {}

-- jsonls: JSON
nvim_lsp.jsonls.setup {}

-- intelephense: PHP
nvim_lsp.intelephense.setup {}

-- sourcekit: Swift
nvim_lsp.sourcekit.setup {}

-- awk_ls: awk
nvim_lsp.awk_ls.setup {}

-- clojure_lsp: Clojure
nvim_lsp.clojure_lsp.setup {}

-- jdtls: Java
nvim_lsp.jdtls.setup {}

-- gopls: Golang
nvim_lsp.gopls.setup {}

-- rust_analyzer: Rust
nvim_lsp.rust_analyzer.setup {
  cmd = { 'rust-analyzer' },
  filetypes = {
    'rust',
  },
  settings = {
    ['rust-analyzer'] = {}
  }
}

-- dockerls: Docker
nvim_lsp.dockerls.setup {}

-- emmet_ls: Emmet
nvim_lsp.emmet_ls.setup {}

-- tailwindcss: TailwindCSS
nvim_lsp.tailwindcss.setup {
  settings = {
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
  },
}

-- bashls: Bash
nvim_lsp.bashls.setup {}

-- ccls: C/C++
nvim_lsp.ccls.setup {
  cmd = { 'ccls' },
  filetypes = {
    'c',
    'cpp',
    'objc',
    'objcpp',
  }
}

-- omnisharp: C#
-- nvim_lsp.omnisharp.setup {
--   cmd = { "dotnet", "/path/to/omnisharp/Omnisharp.dll" }
-- }

-- sqlls: SQL
nvim_lsp.sqlls.setup {}

-- solargraph: Ruby
nvim_lsp.solargraph.setup {
  cmd = { 'solargraph', 'stdio' },
  filetypes = { 'ruby' },
  init_options = {
    formatting = true
  },
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

-- powershell_es: PowerShell
-- nvim_lsp.powershell_es.setup {
--   -- cmd = {},
--   filetypes = {
--     'ps1'
--   }
-- }

-- pylsp: Python
nvim_lsp.pylsp.setup {}

-- volar: Vue
nvim_lsp.volar.setup {}

-- solidity_ls: Solidity
nvim_lsp.solidity_ls.setup {}

-- sumneko_lua: Lua
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
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
}
