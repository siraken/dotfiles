{ pkgs, ... }:
{
  programs.neovide = {
    enable = true;

    settings = {
      vsync = true;
      maximized = false;
      frame = "full";
      title-hidden = true;
      tabs = true;

      font = {
        normal = [ "Hack Nerd Font" ];
        size = 16;
      };
    };
  };
}
