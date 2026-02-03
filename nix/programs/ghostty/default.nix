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
      shell-integration = "zsh";

      # Font settings
      font-family = "Hack Nerd Font Mono";
      font-size = if isDarwin then 16 else 12;
      adjust-cell-height = "20%";

      # Appearance
      theme = "TokyoNight";
      background-opacity = 0.7;
      background-blur-radius = 13;

      # Window settings
      window-padding-x = 0;
      window-padding-y = 0;
      macos-titlebar-style = "tabs";

      confirm-close-surface = false;
      quit-after-last-window-closed = true;

      keybind = [
        "alt+d=new_split:right"
        "alt+shift+d=new_split:down"
      ];
    };
  };
}
