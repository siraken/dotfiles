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

-- intelephense: PHP
nvim_lsp.intelephense.setup {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' }
}

-- denols: Deno
nvim_lsp.denols.setup {
  root_dir = nvim_lsp.util.root_pattern('deno.json'),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ['https://deno.land'] = true,
          ['https://cdn.next.land'] = true,
          ['https://crux.land'] = true,
        }
      }
    }
  }
}

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

-- astro: Astro
nvim_lsp.astro.setup {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  init_options = {
    configuration = {},
    typescript = {
      server = ''
    }
  },
  root_dir = nvim_lsp.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')
}

-- jsonls: JSON
nvim_lsp.jsonls.setup {
  filetypes = {
    'json', 'jsonc'
  },
  settngs = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json'
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json'
        }
      }
    }
  }
}

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
nvim_lsp.dockerls.setup {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = {
    'dockerfile',
  }
}

-- emmet_ls: Emmet
nvim_lsp.emmet_ls.setup {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = {
    'html',
    'javascriptreact',
    'typescriptreact',
    'css',
    'sass',
    'scss',
    'less',
  }
}

-- tailwindcss: TailwindCSS
nvim_lsp.tailwindcss.setup {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'blade',
    'django-html',
    'htmldjango',
    'ejs',
    'erb',
    'eruby',
    'haml',
    'html',
    'jade',
    'leaf',
    'liquid',
    'php',
    'razor',
    'slim',
    'twig',
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },
  root_dir = nvim_lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
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
  },
}

-- bashls: Bash
nvim_lsp.bashls.setup {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh' },
}

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
--   filetypes = { 'cs', 'vb' }
-- }

-- sqlls: SQL
nvim_lsp.sqlls.setup {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = {
    'sql',
    'mysql'
  },
  settings = {}
}

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
nvim_lsp.pylsp.setup {
  cmd = { 'pylsp' },
  filetypes = { 'python' }
}

-- volar: Vue
nvim_lsp.volar.setup {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  -- init_options = {}
}

-- solidity_ls: Solidity
nvim_lsp.solidity_ls.setup {
  cmd = { 'solidity-language-server', '--stdio' },
  filetypes = { 'solidity' },
}

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
