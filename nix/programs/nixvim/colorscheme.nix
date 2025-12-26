# Colorscheme configuration
{ ... }:
{
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        terminal_colors = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
        day_brightness = 0.3;
      };
    };
  };
}
