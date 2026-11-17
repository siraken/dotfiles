# The desktop's colours, generated from nix/colors/tokyonight.nix into
# ~/.config/desktop-theme so the native config files in config/ pull them in
# instead of repeating hex codes:
#
#   colors.css   GTK CSS: Waybar, swaync, swayosd, wlogout (@import)
#   fuzzel.ini   fuzzel's [colors] section (include)
#   colors.conf  hyprlang variables: hyprlock (source)
{ lib, ... }:
let
  tn = import ../../colors/tokyonight.nix;
  strip = lib.removePrefix "#";

  palette = {
    bg = tn.ui.bg;
    bgDark = tn.ui.bgMenu;
    surface = tn.ui.bgFocus;
    selection = tn.ui.bgSelection;
    # The border of siraken-mbp's Sketchybar islands; not in the palette.
    border = "#2f3549";
    fg = tn.white;
    fgDark = tn.ui.fgDark;
    muted = tn.comment;
    blue = tn.blue;
    cyan = tn.cyan;
    green = tn.lightGreen;
    yellow = tn.yellow;
    orange = tn.orange;
    red = tn.red;
    magenta = tn.magenta;
  };

  css = lib.concatStrings (lib.mapAttrsToList (n: v: "@define-color ${n} ${v};\n") palette);

  hyprlang = lib.concatStrings (lib.mapAttrsToList (n: v: "\$${n} = rgba(${strip v}ff)\n") palette);

  fuzzel = with palette; ''
    [colors]
    background=${strip bg}f2
    text=${strip fg}ff
    prompt=${strip blue}ff
    placeholder=${strip muted}ff
    input=${strip fg}ff
    match=${strip green}ff
    selection=${strip selection}ff
    selection-text=${strip fg}ff
    selection-match=${strip green}ff
    border=${strip border}ff
  '';

  header =
    comment:
    "${comment} Generated from nix/colors/tokyonight.nix (nix/programs/hyprland/colors.nix).\n";
in
{
  xdg.configFile = {
    "desktop-theme/colors.css".text = header "/*" + "*/\n" + css;
    "desktop-theme/fuzzel.ini".text = header "#" + fuzzel;
    "desktop-theme/colors.conf".text = header "#" + hyprlang;
  };
}
