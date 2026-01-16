{ pkgs, ... }:
let
  colors = import ../colors/tokyonight.nix;
in
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        avg_cpu = true;
        temperature_type = "c";
      };

      styles = {
        cpu = {
          all_entry_color = colors.magenta;
          avg_entry_color = colors.cyan;
          cpu_core_colors = [
            colors.blue
            colors.cyan
            colors.green
            colors.lightGreen
            colors.yellow
            colors.orange
            colors.red
            colors.magenta
          ];
        };

        memory = {
          ram_color = colors.cyan;
          cache_color = colors.blue;
          swap_color = colors.orange;
          arc_color = colors.purple;
          gpu_colors = [
            colors.lightGreen
            colors.teal
          ];
        };

        network = {
          rx_color = colors.green;
          tx_color = colors.magenta;
          rx_total_color = colors.lightGreen;
          tx_total_color = colors.purple;
        };

        battery = {
          high_battery_color = colors.green;
          medium_battery_color = colors.yellow;
          low_battery_color = colors.red;
        };

        tables = {
          headers = {
            color = colors.blue;
          };
        };

        graphs = {
          graph_color = colors.ui.fgGutter;
          legend_text = {
            color = colors.ui.fgDark;
          };
        };

        widgets = {
          border_color = colors.ui.fgGutter;
          selected_border_color = colors.blue;
          widget_title = {
            color = colors.ui.fg;
          };
          text = {
            color = colors.ui.fg;
          };
          selected_text = {
            color = colors.ui.bg;
            bg_color = colors.blue;
          };
          disabled_text = {
            color = colors.comment;
          };
        };
      };
    };
  };
}
