{ ... }:
let
  # nf-fa-caret_right (U+F0DA), as a JSON escape: the private-use glyph
  # written literally was silently dropped once, leaving an empty sign.
  deleteSign = builtins.fromJSON ''"\uf0da"'';
in
{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text = "▎";
        change.text = "▎";
        delete.text = deleteSign;
        topdelete.text = deleteSign;
        changedelete.text = "▎";
        untracked.text = "▎";
      };
      on_attach.__raw = builtins.readFile ./gitsigns-on-attach.lua;
    };
  };
}
