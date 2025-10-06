{ pkgs, ... }:
{
  programs.kakoune = {
    enable = true;

    config = {
      colorScheme = "solarized-dark";
      numberLines = {
        enable = true;
        highlightCursor = true;
      };
    };
  };
}
