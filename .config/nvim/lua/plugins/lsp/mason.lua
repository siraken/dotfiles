return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "prettierd",
      "eslint_d",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
