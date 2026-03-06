{ ... }:
let
  colors = import ../../colors/tokyonight.nix;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        {
          type = "os";
          keyColor = "blue";
        }
        {
          type = "host";
          keyColor = "blue";
        }
        {
          type = "kernel";
          keyColor = "blue";
        }
        {
          type = "uptime";
          keyColor = "green";
        }
        {
          type = "packages";
          keyColor = "green";
        }
        {
          type = "shell";
          keyColor = "green";
        }
        {
          type = "display";
          keyColor = "cyan";
        }
        {
          type = "de";
          keyColor = "cyan";
        }
        {
          type = "wm";
          keyColor = "cyan";
        }
        {
          type = "wmtheme";
          keyColor = "cyan";
        }
        {
          type = "theme";
          keyColor = "cyan";
        }
        {
          type = "icons";
          keyColor = "cyan";
        }
        {
          type = "font";
          keyColor = "cyan";
        }
        {
          type = "cursor";
          keyColor = "cyan";
        }
        {
          type = "terminal";
          keyColor = "cyan";
        }
        {
          type = "terminalfont";
          keyColor = "cyan";
        }
        "separator"
        {
          type = "cpu";
          keyColor = "magenta";
        }
        {
          type = "gpu";
          keyColor = "magenta";
        }
        {
          type = "memory";
          keyColor = "magenta";
        }
        {
          type = "swap";
          keyColor = "magenta";
        }
        {
          type = "disk";
          keyColor = "yellow";
        }
        {
          type = "localip";
          keyColor = "yellow";
        }
        {
          type = "battery";
          keyColor = "yellow";
        }
        {
          type = "poweradapter";
          keyColor = "yellow";
        }
        {
          type = "locale";
          keyColor = "yellow";
        }
        "break"
        "colors"
      ];
    };
  };
}
