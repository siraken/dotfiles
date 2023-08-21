-- https://github.com/folke/noice.nvim
--
-- icons:
-- https://www.nerdfonts.com/cheat-sheet
local status, noice = pcall(require, 'noice')
if (not status) then return end

noice.setup {
  cmdline = {
    format = {
      cmdline = {
        pattern = "^:", icon = "", lang = "vim"
      },
      search_down = {
        kind = "search", pattern = "^/", icon = " ", lang = "regex"
      },
      search_up = {
        kind = "search", pattern = "^%?", icon = " ", lang = "regex"
      },
      filter = {
        pattern = "^:%s*!", icon = "$", lang = "bash"
      },
      lua = {
        pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
        icon = "",
        lang = "lua"
      },
      help = {
        pattern = "^:%s*he?l?p?%s+", icon = "󰋗"
      },
    }
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "mini",
  },
  routes = {
    {
      view = "mini",
      filter = {
        find = "written",
      }
    }
  },
  lsp = {
    signature = {
      enabled = false,
    },
  },
  health = {
    checker = true,
  }
}

