function()
  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local fileformat = vim.bo.fileformat
  local branch = vim.b.gitsigns_head or ""
  local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_names = {}
  for _, client in ipairs(lsp_clients) do
    table.insert(lsp_names, client.name)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {
    "╭─ File Info ─────────────────────────────────╮",
    "│ File: " .. filename,
    "│ Type: " .. filetype,
    "│ Encoding: " .. encoding,
    "│ Format: " .. fileformat,
    "├─ Git ───────────────────────────────────────┤",
    "│ Branch: " .. (branch ~= "" and branch or "N/A"),
    "├─ LSP ───────────────────────────────────────┤",
    "│ Servers: " .. (#lsp_names > 0 and table.concat(lsp_names, ", ") or "None"),
    "╰─────────────────────────────────────────────╯",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local width = math.min(50, math.max(1, vim.o.columns - 4))
  local height = math.min(#lines, math.max(1, vim.o.lines - 4))
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.max(0, math.floor((vim.o.columns - width) / 2)),
    row = math.max(0, math.floor((vim.o.lines - height) / 2)),
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end
