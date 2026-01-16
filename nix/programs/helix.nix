{ pkgs, ... }:
let
  colors = import ../colors/tokyonight.nix;
  c = colors;
  ui = colors.uiTransparent; # Use transparent variant
in
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
      # ofunato-night: tokyonight-inspired dark theme (with transparency support)
      ofunato-night = {
        # Syntax highlighting
        "attribute" = {
          fg = c.cyan;
        };
        "comment" = {
          fg = c.comment;
          modifiers = [ "italic" ];
        };
        "comment.block.documentation" = {
          fg = c.yellow;
        };
        "comment.line.documentation" = {
          fg = c.yellow;
        };
        "constant" = {
          fg = c.orange;
        };
        "constant.builtin" = {
          fg = c.aqua;
        };
        "constant.character" = {
          fg = c.lightGreen;
        };
        "constant.character.escape" = {
          fg = c.magenta;
        };
        "constructor" = {
          fg = c.aqua;
        };
        "function" = {
          fg = c.blue;
          modifiers = [ "italic" ];
        };
        "function.builtin" = {
          fg = c.aqua;
        };
        "function.macro" = {
          fg = c.cyan;
        };
        "function.special" = {
          fg = c.cyan;
        };
        "keyword" = {
          fg = c.purple;
          modifiers = [ "italic" ];
        };
        "keyword.control" = {
          fg = c.magenta;
        };
        "keyword.control.import" = {
          fg = c.cyan;
        };
        "keyword.control.return" = {
          fg = c.purple;
          modifiers = [ "italic" ];
        };
        "keyword.directive" = {
          fg = c.cyan;
        };
        "keyword.function" = {
          fg = c.magenta;
        };
        "keyword.operator" = {
          fg = c.magenta;
        };
        "label" = {
          fg = c.blue;
        };
        "namespace" = {
          fg = c.cyan;
        };
        "operator" = {
          fg = c.turquoise;
        };
        "punctuation" = {
          fg = c.turquoise;
        };
        "special" = {
          fg = c.aqua;
        };
        "string" = {
          fg = c.lightGreen;
        };
        "string.regexp" = {
          fg = c.lightCyan;
        };
        "string.special" = {
          fg = c.aqua;
        };
        "tag" = {
          fg = c.magenta;
        };
        "type" = {
          fg = c.aqua;
        };
        "type.builtin" = {
          fg = c.aqua;
        };
        "type.enum.variant" = {
          fg = c.orange;
        };
        "variable" = {
          fg = ui.fg;
        };
        "variable.builtin" = {
          fg = c.red;
        };
        "variable.other.member" = {
          fg = c.green;
        };
        "variable.parameter" = {
          fg = c.yellow;
          modifiers = [ "italic" ];
        };

        # Markup
        "markup.bold" = {
          modifiers = [ "bold" ];
        };
        "markup.heading" = {
          fg = c.blue;
          modifiers = [ "bold" ];
        };
        "markup.heading.completion" = {
          bg = ui.bgMenu;
          fg = ui.fg;
        };
        "markup.heading.hover" = {
          bg = ui.fgSelected;
        };
        "markup.italic" = {
          modifiers = [ "italic" ];
        };
        "markup.link" = {
          fg = c.blue;
          underline = {
            style = "line";
          };
        };
        "markup.link.label" = {
          fg = c.teal;
        };
        "markup.link.text" = {
          fg = c.teal;
        };
        "markup.link.url" = {
          underline = {
            style = "line";
          };
        };
        "markup.list" = {
          fg = c.orange;
          modifiers = [ "bold" ];
        };
        "markup.normal.completion" = {
          fg = c.comment;
        };
        "markup.normal.hover" = {
          fg = ui.fgDark;
        };
        "markup.raw" = {
          fg = c.teal;
        };
        "markup.raw.inline" = {
          bg = c.black;
          fg = c.blue;
        };
        "markup.strikethrough" = {
          modifiers = [ "crossed_out" ];
        };

        # Diff
        "diff.delta" = {
          fg = c.git.change;
        };
        "diff.delta.moved" = {
          fg = c.blue;
        };
        "diff.minus" = {
          fg = c.git.delete;
        };
        "diff.plus" = {
          fg = c.git.add;
        };

        # Diagnostics
        "error" = {
          fg = c.diagnostic.error;
        };
        "warning" = {
          fg = c.yellow;
        };
        "info" = {
          fg = c.diagnostic.info;
        };
        "hint" = {
          fg = c.diagnostic.hint;
        };
        "diagnostic.error" = {
          underline = {
            style = "curl";
            color = c.diagnostic.error;
          };
        };
        "diagnostic.warning" = {
          underline = {
            style = "curl";
            color = c.yellow;
          };
        };
        "diagnostic.info" = {
          underline = {
            style = "curl";
            color = c.diagnostic.info;
          };
        };
        "diagnostic.hint" = {
          underline = {
            style = "curl";
            color = c.diagnostic.hint;
          };
        };
        "diagnostic.unnecessary" = {
          modifiers = [ "dim" ];
        };
        "diagnostic.deprecated" = {
          modifiers = [ "crossed_out" ];
        };

        # UI
        "ui.background" = {
          bg = ui.bg; # "none" for transparency
          fg = ui.fg;
        };
        "ui.cursor" = {
          modifiers = [ "reversed" ];
        };
        "ui.cursor.match" = {
          fg = c.orange;
          modifiers = [ "bold" ];
        };
        "ui.cursorline.primary" = {
          bg = ui.bgMenu;
        };
        "ui.help" = {
          bg = ui.bgMenu;
          fg = ui.fg;
        };
        "ui.linenr" = {
          fg = ui.fgGutter;
        };
        "ui.linenr.selected" = {
          fg = ui.fgLinenr;
        };
        "ui.menu" = {
          bg = ui.bgMenu;
          fg = ui.fg;
        };
        "ui.menu.selected" = {
          bg = ui.fgSelected;
        };
        "ui.popup" = {
          bg = ui.bgMenu;
          fg = ui.borderHighlight;
        };
        "ui.selection" = {
          bg = ui.bgSelection;
        };
        "ui.selection.primary" = {
          bg = ui.bgSelection;
        };
        "ui.statusline" = {
          bg = ui.bgMenu;
          fg = ui.fgDark;
        };
        "ui.statusline.inactive" = {
          bg = ui.bgMenu;
          fg = ui.fgGutter;
        };
        "ui.statusline.normal" = {
          bg = c.blue;
          fg = colors.ui.bg; # Use opaque bg for contrast
          modifiers = [ "bold" ];
        };
        "ui.statusline.insert" = {
          bg = c.lightGreen;
          fg = colors.ui.bg;
          modifiers = [ "bold" ];
        };
        "ui.statusline.select" = {
          bg = c.magenta;
          fg = colors.ui.bg;
          modifiers = [ "bold" ];
        };
        "ui.text" = {
          fg = ui.fg;
        };
        "ui.text.focus" = {
          bg = ui.bgFocus;
        };
        "ui.text.inactive" = {
          fg = c.comment;
          modifiers = [ "italic" ];
        };
        "ui.text.info" = {
          bg = ui.bgMenu;
          fg = ui.fg;
        };
        "ui.text.directory" = {
          fg = c.cyan;
        };
        "ui.virtual.ruler" = {
          bg = ui.fgGutter;
        };
        "ui.virtual.whitespace" = {
          fg = ui.fgGutter;
        };
        "ui.virtual.inlay-hint" = {
          bg = colors.ui.bgInlay; # Use opaque for visibility
          fg = c.teal;
        };
        "ui.virtual.jump-label" = {
          fg = c.orange;
          modifiers = [ "bold" ];
        };
        "ui.window" = {
          fg = ui.border;
          modifiers = [ "bold" ];
        };
      };
    };
  };
}
