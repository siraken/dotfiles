# AI assistance plugins (Claude Code)
{ pkgs, ... }:
let
  claudecode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "claudecode-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "coder";
      repo = "claudecode.nvim";
      rev = "6091df0e8edcdc92526cec23bbb42f63c0bb5ff2";
      hash = "sha256-PmSYIE7j9C2ckJc9wDIm4KCozXP0z1U9TOdItnDyoDQ=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ claudecode-nvim ];

    extraConfigLua = ''
      require("claudecode").setup({})
    '';

    keymaps = [
      { mode = "n"; key = "<leader>ac"; action = "<cmd>ClaudeCode<cr>"; options.desc = "Toggle Claude"; }
      { mode = "n"; key = "<leader>af"; action = "<cmd>ClaudeCodeFocus<cr>"; options.desc = "Focus Claude"; }
      { mode = "n"; key = "<leader>ar"; action = "<cmd>ClaudeCode --resume<cr>"; options.desc = "Resume Claude"; }
      { mode = "n"; key = "<leader>aC"; action = "<cmd>ClaudeCode --continue<cr>"; options.desc = "Continue Claude"; }
      { mode = "n"; key = "<leader>am"; action = "<cmd>ClaudeCodeSelectModel<cr>"; options.desc = "Select Claude model"; }
      { mode = "n"; key = "<leader>ab"; action = "<cmd>ClaudeCodeAdd %<cr>"; options.desc = "Add current buffer"; }
      { mode = "v"; key = "<leader>as"; action = "<cmd>ClaudeCodeSend<cr>"; options.desc = "Send to Claude"; }
      # Diff management
      { mode = "n"; key = "<leader>aa"; action = "<cmd>ClaudeCodeDiffAccept<cr>"; options.desc = "Accept diff"; }
      { mode = "n"; key = "<leader>ad"; action = "<cmd>ClaudeCodeDiffDeny<cr>"; options.desc = "Deny diff"; }
    ];
  };
}
