local keymap = vim.keymap
local vscode = vim.g.vscode

-- Increment / decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap.set("n", "ss", ":split<CR><C-W>w", { desc = "Split horizontal" })
keymap.set("n", "sv", ":vsplit<CR><C-w>w", { desc = "Split vertical" })

-- Move window
keymap.set("n", "sh", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "sk", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "sj", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "sl", "<C-w>l", { desc = "Go to right window" })

-- Resize window
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Close buffer
keymap.set("n", "<leader>bd", function() require("snacks").bufdelete() end, { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete buffer and window" })

-- Use Shift + U as redo
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Reselect visual block after indents
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Use Tab, Shift + Tab
keymap.set("i", "<S-Tab>", "<C-d>")
keymap.set("v", "<Tab>", ">>")
keymap.set("v", "<S-Tab>", "<<")

-- Stay visual mode after formatting
keymap.set("v", "=", "=gv")

-- Better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear search" })

-- Quit all
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Diagnostic navigation
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

if not vscode then
  keymap.set("n", "tr", "<Cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })
else
  keymap.set("n", "tr", "<Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
end

-- UI toggles
keymap.set("n", "<leader>un", function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle line numbers" })

keymap.set("n", "<leader>ui", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local fileformat = vim.bo.fileformat
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  local mode = vim.fn.mode()
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
end, { desc = "Show file info" })
