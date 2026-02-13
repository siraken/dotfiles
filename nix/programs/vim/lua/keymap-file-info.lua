function()
  local buf = vim.api.nvim_create_buf(false, true)
  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local fileformat = vim.bo.fileformat
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_names = {}
  for _, client in ipairs(lsp_clients) do
    table.insert(lsp_names, client.name)
  end

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
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  local width = 50
  local height = #lines
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end
