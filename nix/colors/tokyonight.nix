# TokyoNight color palette
# Based on https://github.com/folke/tokyonight.nvim (night variant)
# Extracted from helix ofunato-night theme
{
  # Main colors
  red = "#f7768e";
  orange = "#ff9e64";
  yellow = "#e0af68";
  lightGreen = "#9ece6a";
  green = "#73daca";
  aqua = "#2ac3de";
  teal = "#1abc9c";
  turquoise = "#89ddff";
  lightCyan = "#b4f9f8";
  cyan = "#7dcfff";
  blue = "#7aa2f7";
  purple = "#9d7cd8";
  magenta = "#bb9af7";
  white = "#c0caf5";

  # Grayscale
  comment = "#565f89";
  black = "#414868";
  darkBlack = "#15161e";

  # Git colors
  git = {
    add = "#449dab";
    change = "#6183bb";
    delete = "#914c54";
  };

  # Diagnostic colors
  diagnostic = {
    error = "#db4b4b";
    warning = "#e0af68"; # same as yellow
    info = "#0db9d7";
    hint = "#1abc9c"; # same as teal
  };

  # UI colors (opaque)
  ui = {
    fg = "#c0caf5";
    fgDark = "#a9b1d6";
    fgGutter = "#3b4261";
    fgLinenr = "#737aa2";
    fgSelected = "#343a55";
    border = "#15161e";
    borderHighlight = "#27a1b9";
    bg = "#1a1b26";
    bgInlay = "#1a2b32";
    bgSelection = "#283457";
    bgMenu = "#16161e";
    bgFocus = "#292e42";
  };

  # UI colors (transparent variant)
  uiTransparent = {
    fg = "#c0caf5";
    fgDark = "#a9b1d6";
    fgGutter = "#3b4261";
    fgLinenr = "#737aa2";
    fgSelected = "#343a55";
    border = "#15161e";
    borderHighlight = "#27a1b9";
    bg = "none";
    bgInlay = "#1a2b32";
    bgSelection = "#283457";
    bgMenu = "#16161e";
    bgFocus = "#292e42";
  };

  # FZF color scheme
  fzf = {
    fg = "#c0caf5";
    bg = "#1a1b26";
    hl = "#7dcfff";
    fgPlus = "#c0caf5";
    bgPlus = "#283457";
    hlPlus = "#7dcfff";
    info = "#7aa2f7";
    prompt = "#bb9af7";
    pointer = "#bb9af7";
    marker = "#9ece6a";
    spinner = "#bb9af7";
    header = "#7dcfff";
    border = "#27a1b9";
  };

  # FZF transparent variant
  fzfTransparent = {
    fg = "#c0caf5";
    bg = "-1";
    hl = "#7dcfff";
    fgPlus = "#c0caf5";
    bgPlus = "#283457";
    hlPlus = "#7dcfff";
    info = "#7aa2f7";
    prompt = "#bb9af7";
    pointer = "#bb9af7";
    marker = "#9ece6a";
    spinner = "#bb9af7";
    header = "#7dcfff";
    border = "#27a1b9";
  };
}
