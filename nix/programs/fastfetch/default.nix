{ ... }:
let
  colors = import ../../colors/tokyonight.nix;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        padding = {
          top = 1;
        };
      };

      display = {
        separator = "  ";
        key.width = 12;
      };

      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "OS";
          keyColor = "blue";
        }
        {
          type = "host";
          key = "Host";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "Kernel";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "Uptime";
          keyColor = "green";
        }
        {
          type = "packages";
          key = "Packages";
          keyColor = "green";
        }
        {
          type = "shell";
          key = "Shell";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "Terminal";
          keyColor = "cyan";
        }
        {
          type = "de";
          key = "DE";
          keyColor = "cyan";
        }
        {
          type = "wm";
          key = "WM";
          keyColor = "cyan";
        }
        "separator"
        {
          type = "cpu";
          key = "CPU";
          keyColor = "magenta";
        }
        {
          type = "gpu";
          key = "GPU";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "Memory";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "Disk";
          keyColor = "yellow";
        }
        {
          type = "battery";
          key = "Battery";
          keyColor = "yellow";
        }
        {
          type = "locale";
          key = "Locale";
          keyColor = "yellow";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
