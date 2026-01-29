{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      features = {
        edit_prediction_provider = "zed";
      };
      vim_mode = false;
      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "Hack Nerd Font Mono";
      theme = {
        mode = "system";
        light = "Tokyo Night Light";
        dark = "Tokyo Night";
      };
      terminal = {
        shell = {
          program = "bash";
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
