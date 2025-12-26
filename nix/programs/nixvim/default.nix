# Nixvim configuration entry point
{ pkgs, lib, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./colorscheme.nix
    ./plugins/core.nix
    ./plugins/lsp.nix
    ./plugins/completion.nix
    ./plugins/treesitter.nix
    ./plugins/ui.nix
    ./plugins/editor.nix
    ./plugins/coding.nix
    ./plugins/git.nix
    ./plugins/ai.nix
    ./plugins/lang/rust.nix
    ./plugins/lang/python.nix
    ./plugins/lang/java.nix
    ./plugins/lang/lisp.nix
    ./plugins/lang/clojure.nix
    ./plugins/lang/dotnet.nix
    ./plugins/lang/markdown.nix
    ./plugins/lang/web.nix
    ./misc.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
