# Key mappings configuration
{ ... }:
{
  programs.nixvim = {
    keymaps = [
      # Increment / decrement
      { mode = "n"; key = "+"; action = "<C-a>"; }
      { mode = "n"; key = "-"; action = "<C-x>"; }

      # Select all
      { mode = "n"; key = "<C-a>"; action = "gg<S-v>G"; }

      # Split window
      { mode = "n"; key = "ss"; action = "<cmd>split<cr><C-w>w"; options.desc = "Split horizontal"; }
      { mode = "n"; key = "sv"; action = "<cmd>vsplit<cr><C-w>w"; options.desc = "Split vertical"; }

      # Move window
      { mode = "n"; key = "sh"; action = "<C-w>h"; options.desc = "Go to left window"; }
      { mode = "n"; key = "sk"; action = "<C-w>k"; options.desc = "Go to upper window"; }
      { mode = "n"; key = "sj"; action = "<C-w>j"; options.desc = "Go to lower window"; }
      { mode = "n"; key = "sl"; action = "<C-w>l"; options.desc = "Go to right window"; }

      # Resize window
      { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<cr>"; options.desc = "Increase height"; }
      { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<cr>"; options.desc = "Decrease height"; }
      { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<cr>"; options.desc = "Decrease width"; }
      { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<cr>"; options.desc = "Increase width"; }

      # Close buffer (snacks.bufdelete)
      { mode = "n"; key = "<leader>bd"; action.__raw = "function() require('snacks').bufdelete() end"; options.desc = "Delete buffer"; }
      { mode = "n"; key = "<leader>bD"; action = "<cmd>:bd<cr>"; options.desc = "Delete buffer and window"; }

      # Use Shift + U as redo
      { mode = "n"; key = "U"; action = "<C-r>"; options.desc = "Redo"; }

      # Reselect visual block after indents
      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }

      # Use Tab, Shift + Tab
      { mode = "i"; key = "<S-Tab>"; action = "<C-d>"; }
      { mode = "v"; key = "<Tab>"; action = ">>"; }
      { mode = "v"; key = "<S-Tab>"; action = "<<"; }

      # Stay visual mode after formatting
      { mode = "v"; key = "="; action = "=gv"; }

      # Move lines
      { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<cr>=="; options.desc = "Move down"; }
      { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<cr>=="; options.desc = "Move up"; }
      { mode = "i"; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; options.desc = "Move down"; }
      { mode = "i"; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; options.desc = "Move up"; }
      { mode = "v"; key = "<A-j>"; action = ":m '>+1<cr>gv=gv"; options.desc = "Move down"; }
      { mode = "v"; key = "<A-k>"; action = ":m '<-2<cr>gv=gv"; options.desc = "Move up"; }

      # Clear search with <esc>
      { mode = [ "i" "n" ]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; options.desc = "Escape and clear search"; }

      # Quit all
      { mode = "n"; key = "<leader>qq"; action = "<cmd>qa<cr>"; options.desc = "Quit all"; }

      # New file
      { mode = "n"; key = "<leader>fn"; action = "<cmd>enew<cr>"; options.desc = "New file"; }

      # Diagnostic navigation
      { mode = "n"; key = "]d"; action.__raw = "vim.diagnostic.goto_next"; options.desc = "Next diagnostic"; }
      { mode = "n"; key = "[d"; action.__raw = "vim.diagnostic.goto_prev"; options.desc = "Prev diagnostic"; }
      { mode = "n"; key = "<leader>cd"; action.__raw = "vim.diagnostic.open_float"; options.desc = "Line diagnostics"; }

      # UI toggles
      {
        mode = "n";
        key = "<leader>un";
        action.__raw = ''
          function()
            vim.wo.number = not vim.wo.number
            vim.wo.relativenumber = not vim.wo.relativenumber
          end
        '';
        options.desc = "Toggle line numbers";
      }
    ];

    # Better up/down (requires expr = true which keymaps doesn't support directly)
    extraConfigLua = ''
      vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
      vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

      -- File info popup
      vim.keymap.set("n", "<leader>ui", function()
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
          "-- File Info ------------------------------",
          "| File: " .. filename,
          "| Type: " .. filetype,
          "| Encoding: " .. encoding,
          "| Format: " .. fileformat,
          "-- Git ------------------------------------",
          "| Branch: " .. (branch ~= "" and branch or "N/A"),
          "-- LSP ------------------------------------",
          "| Servers: " .. (#lsp_names > 0 and table.concat(lsp_names, ", ") or "None"),
          "-------------------------------------------",
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
    '';
  };
}
