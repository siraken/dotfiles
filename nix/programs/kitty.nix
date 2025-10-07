{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    settings = {
      font_size = "16.0";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      background_opacity = "0.5";
      background_blur = 1;
      dynamic_background_opacity = true;
    };
  };
}
