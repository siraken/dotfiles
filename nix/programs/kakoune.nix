{ pkgs, ... }:
{
  programs.kakoune = {
    enable = true;
    config = {
      colorScheme = "solarized-dark";
      # autoComplete = "prompt";
      autoReload = "yes";
      numberLines = {
        enable = true;
        relative = true;
        highlightCursor = true;
      };
    };
  };
}
