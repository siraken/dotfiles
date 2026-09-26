{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = false;

    settings = {
      theme = "ofunato-night";

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

    ignores = [ ];

    languages = {
      language = [
        {
          name = "php";
          language-servers = [ "intelephense" ];
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }
      ];
    };

    themes = {
      ofunato-night = import ./themes/ofunato-night.nix;
    };
  };
}
