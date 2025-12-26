# AI assistance plugins (Claude Code)
{ pkgs, ... }:
let
  claude-code-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "claude-code-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "greggh";
      repo = "claude-code.nvim";
      rev = "c9a31e51069977edaad9560473b5d031fcc5d38b";
      hash = "sha256-ZEIPutxhgyaAhq+fJw1lTO781IdjTXbjKy5yKgqSLjM=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ claude-code-nvim ];

    extraConfigLua = ''
      require("claude-code").setup({})

      -- ft-specific keymap for adding files from file explorers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "neo-tree", "oil", "minifiles", "netrw" },
        callback = function(args)
          vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", {
            buffer = args.buf,
            desc = "Add file",
          })
        end,
      })
    '';

    keymaps = [
      { mode = "n"; key = "<leader>ac"; action = "<cmd>ClaudeCode<cr>"; options.desc = "Toggle Claude"; }
      { mode = "n"; key = "<leader>af"; action = "<cmd>ClaudeCodeFocus<cr>"; options.desc = "Focus Claude"; }
      { mode = "n"; key = "<leader>ar"; action = "<cmd>ClaudeCode --resume<cr>"; options.desc = "Resume Claude"; }
      { mode = "n"; key = "<leader>aC"; action = "<cmd>ClaudeCode --continue<cr>"; options.desc = "Continue Claude"; }
      { mode = "n"; key = "<leader>am"; action = "<cmd>ClaudeCodeSelectModel<cr>"; options.desc = "Select Claude model"; }
      { mode = "n"; key = "<leader>ab"; action = "<cmd>ClaudeCodeAdd %<cr>"; options.desc = "Add current buffer"; }
      { mode = "v"; key = "<leader>as"; action = "<cmd>ClaudeCodeSend<cr>"; options.desc = "Send to Claude"; }
      { mode = "n"; key = "<leader>aa"; action = "<cmd>ClaudeCodeDiffAccept<cr>"; options.desc = "Accept diff"; }
      { mode = "n"; key = "<leader>ad"; action = "<cmd>ClaudeCodeDiffDeny<cr>"; options.desc = "Deny diff"; }
    ];
  };
}
