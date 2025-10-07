{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = "ayu_dark";

      editor = {
        line-number = "absolute";
        mouse = false;
        idle-timeout = 0;

        lsp = {
          display-messages = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
          character = "╎";
        };
      };
    };

    languages = {
      language = [
        {
          name = "php";
          language-servers = [ "intelephense" ];
        }
      ];
    };
  };
}
