{ pkgs, ... }:
{
  programs.lazydocker = {
    enable = true;
    settings = {
      gui = {
        theme = {
          # Limited theming - only basic ANSI colors supported (no hex)
          activeBorderColor = [
            "yellow"
            "bold"
          ];
          inactiveBorderColor = [
            "white"
          ];
          selectedLineBgColor = [
            "blue"
          ];
          optionsTextColor = [
            "blue"
          ];
        };
      };
    };
  };
}
