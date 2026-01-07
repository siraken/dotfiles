{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = false;

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

        keys = { };
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
      ofunato-night =
        let
        in
        { };
    };
  };
}
