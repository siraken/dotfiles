# The desktop's colours, generated from nix/colors/tokyonight.nix into
# ~/.config/desktop-theme so the native config files in config/ pull them in
# instead of repeating hex codes:
#
#   colors.css   GTK CSS: Waybar, swaync, swayosd, wlogout (@import)
#   rofi.rasi    rofi's colour variables (@import)
#   foot.ini     foot's [colors-dark] section (include)
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

  rofi = with palette; ''
    * {
      bg: ${bg}f2;
      bg-alt: ${bgDark};
      fg: ${fg};
      muted: ${muted};
      accent: ${blue};
      match: ${green};
      sel: ${selection};
      border-col: ${border};
    }

    /* highlight takes no variables. */
    element-text {
      highlight: bold ${green};
    }
  '';

  # Terminal colours for foot, the fallback terminal the bar's panels open in.
  foot = ''
    [colors-dark]
    foreground=${strip tn.ui.fgDark}
    background=${strip tn.ui.bg}
    selection-foreground=${strip tn.white}
    selection-background=${strip tn.ui.bgSelection}
    regular0=${strip tn.darkBlack}
    regular1=${strip tn.red}
    regular2=${strip tn.lightGreen}
    regular3=${strip tn.yellow}
    regular4=${strip tn.blue}
    regular5=${strip tn.magenta}
    regular6=${strip tn.cyan}
    regular7=${strip tn.ui.fgDark}
    bright0=${strip tn.black}
    bright1=${strip tn.red}
    bright2=${strip tn.lightGreen}
    bright3=${strip tn.yellow}
    bright4=${strip tn.blue}
    bright5=${strip tn.magenta}
    bright6=${strip tn.cyan}
    bright7=${strip tn.white}
  '';

  header =
    comment:
    "${comment} Generated from nix/colors/tokyonight.nix (nix/programs/hyprland/colors.nix).\n";
in
{
  xdg.configFile = {
    "desktop-theme/colors.css".text = header "/*" + "*/\n" + css;
    "desktop-theme/rofi.rasi".text = header "//" + rofi;
    "desktop-theme/colors.conf".text = header "#" + hyprlang;
    "desktop-theme/foot.ini".text = header "#" + foot;
  };
}
