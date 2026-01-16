{ pkgs, ... }:
let
  colors = import ../colors/tokyonight.nix;
  c = colors;
in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      mgr = {
        ratio = [
          2
          3
          3
        ];
        sort_by = "none";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        show_symlink = true;
        mouse_events = [
          "click"
          "scroll"
          "touch"
          "move"
          "drag"
        ];
      };
    };

    theme = {
      # Manager
      mgr = {
        cwd = { fg = c.blue; };
        hovered = { bg = c.ui.bgSelection; };
        preview_hovered = { bg = c.ui.bgSelection; };

        find_keyword = {
          fg = c.red;
          bold = true;
          italic = true;
          underline = true;
        };
        find_position = { fg = c.magenta; italic = true; };

        marker_copied = { fg = c.lightGreen; };
        marker_cut = { fg = c.red; };
        marker_marked = { fg = c.cyan; };
        marker_selected = { fg = c.yellow; };

        tab_active = { fg = c.ui.fg; bg = c.ui.bgMenu; };
        tab_inactive = { fg = c.comment; bg = c.ui.bg; };
        tab_width = 1;

        count_copied = { fg = c.ui.bg; bg = c.lightGreen; };
        count_cut = { fg = c.ui.bg; bg = c.red; };
        count_selected = { fg = c.ui.bg; bg = c.yellow; };

        border = { fg = c.black; };
      };

      # Mode indicators
      mode = {
        normal = { fg = c.blue; bg = c.ui.bgFocus; bold = true; };
        select = { fg = c.ui.bg; bg = c.lightGreen; bold = true; };
        unset = { fg = c.ui.bg; bg = c.magenta; bold = true; };
      };

      # Status bar
      status = {
        sep_open = { fg = c.ui.bgFocus; bg = c.ui.bgFocus; };
        sep_close = { fg = c.ui.bgFocus; bg = c.ui.bgFocus; };

        progress_label = { fg = c.ui.fg; bold = true; };
        progress_normal = { fg = c.blue; };
        progress_error = { fg = c.red; };

        perm_type = { fg = c.green; };
        perm_read = { fg = c.yellow; };
        perm_write = { fg = c.red; };
        perm_exec = { fg = c.magenta; };
        perm_sep = { fg = c.comment; };
      };

      # File types
      filetype = {
        rules = [
          # Images
          { mime = "image/*"; fg = c.yellow; }

          # Media
          { mime = "video/*"; fg = c.red; }
          { mime = "audio/*"; fg = c.red; }

          # Archives
          { mime = "application/zip"; fg = c.magenta; }
          { mime = "application/gzip"; fg = c.magenta; }
          { mime = "application/x-tar"; fg = c.magenta; }
          { mime = "application/x-bzip"; fg = c.magenta; }
          { mime = "application/x-bzip2"; fg = c.magenta; }
          { mime = "application/x-7z-compressed"; fg = c.magenta; }
          { mime = "application/x-rar"; fg = c.magenta; }
          { mime = "application/x-xz"; fg = c.magenta; }

          # Documents
          { mime = "application/pdf"; fg = c.lightGreen; }
          { mime = "application/epub+zip"; fg = c.lightGreen; }
          { mime = "application/msword"; fg = c.lightGreen; }
          { mime = "application/vnd.openxmlformats-officedocument.*"; fg = c.lightGreen; }

          # Fallback
          { name = "*"; fg = c.ui.fg; }
        ];
      };

      # Icons (optional, requires nerd font)
      icon = {
        prepend_rules = [
          { name = "*.nix"; text = ""; fg = c.cyan; }
          { name = "*.lua"; text = ""; fg = c.blue; }
          { name = "*.rs"; text = ""; fg = c.orange; }
          { name = "*.go"; text = ""; fg = c.cyan; }
          { name = "*.ts"; text = ""; fg = c.blue; }
          { name = "*.tsx"; text = ""; fg = c.blue; }
          { name = "*.js"; text = ""; fg = c.yellow; }
          { name = "*.jsx"; text = ""; fg = c.yellow; }
        ];
      };
    };
  };
}
