{ ... }:
{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add.text = "▎";
        change.text = "▎";
        delete.text = "";
        topdelete.text = "";
        changedelete.text = "▎";
        untracked.text = "▎";
      };
      on_attach.__raw = builtins.readFile ./gitsigns-on-attach.lua;
    };
  };
}
