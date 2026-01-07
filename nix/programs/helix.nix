{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = "tokyonight";

      editor = {
        line-number = "relative";
        mouse = true;
        idle-timeout = 0;

        lsp = {
          display-messages = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
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
