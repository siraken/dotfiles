{ pkgs, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.ghostty = {
    enable = true;
    package =
      if isDarwin then
        # TODO: use package for macOS (for now, set `null` to use brew-installed version)
        null
      else
        pkgs.ghostty;
    settings = {
      shell-integration = "detect";

      # Font settings
      font-family = "Hack Nerd Font Mono";
      font-size = if isDarwin then 16 else 12;
      adjust-cell-height = "20%";

      # Appearance
      theme = "TokyoNight";
      background-opacity = 0.7;
      background-blur-radius = 13;

      # Window settings
      window-vsync = true;
      window-padding-x = 0;
      window-padding-y = 0;
      window-padding-color = "background";
      window-decoration = "none";
      window-inherit-working-directory = true;
      macos-titlebar-style = "tabs";

      focus-follows-mouse = false;
      confirm-close-surface = false;
      quit-after-last-window-closed = true;

      keybind = [
        "alt+d=new_split:right"
        "alt+shift+d=new_split:down"
      ];
    };
  };
}
