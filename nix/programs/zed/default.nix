{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      edit_predictions = {
        provider = "zed";
      };
      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      vim = {
        toggle_relative_line_numbers = true;
      };
      ui_font_size = 18;
      agent_ui_font_size = 16;
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
      relative_line_numbers = "enabled";
      tabs = {
        git_status = true;
      };
      git_panel = {
        dock = "left";
      };
      project_panel = {
        dock = "left";
        folder_icons = true;
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
