{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      features = {
        edit_prediction_provider = "zed";
      };
      vim_mode = true;
      ui_font_size = 14;
      buffer_font_size = 14;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      terminal = {
        shell = {
          program = "/opt/homebrew/bin/bash";
        };
        toolbar = {
          breadcrumbs = false;
        };
        font_family = "Hack Nerd Font Mono";
      };
      indent_guides = {
        background_coloring = "indent_aware";
      };
      relative_line_numbers = true;
      tabs = {
        git_status = true;
      };
      lsp = {
        biome = {
          settings = {
            require_config_file = true;
          };
        };
      };
    };
  };
}
