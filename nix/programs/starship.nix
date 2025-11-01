{ pkgs, lib, ... }:
let
  # Set to true to use Tokyo Night theme, false for default theme
  useTokyoNight = false;

  defaultSettings = {
    add_newline = true;
    command_timeout = 500;
    scan_timeout = 30;
    aws = {
      disabled = true;
    };
    docker_context = {
      disabled = true;
    };
    gcloud = {
      disabled = true;
    };
    memory_usage = {
      disabled = true;
      threshold = -1;
      style = "bold dimmed green";
    };
    sudo = {
      disabled = false;
    };
    vagrant = {
      disabled = true;
    };
  };

  tokyoNightSettings = {
    add_newline = true;
    command_timeout = 500;
    scan_timeout = 30;

    format = lib.concatStrings [
      "$os"
      "[](bg:v_secondary fg:v_primary)"
      "$directory"
      "[ ](bg:v_base fg:v_secondary)"
      "$git_branch"
      "$git_status"
      "[](fg:v_base)"
      "$line_break$character"
    ];

    right_format = lib.concatStrings [
      "$localip"
    ];

    palette = "tokyo-night";

    palettes.tokyo-night = {
      git-green = "#6CA53A";
      v_base = "#202334";
      v_primary = "#83A1F1";
      v_secondary = "#3D425F";
      v_tertiary = "#3D4A6D";
      t_base = "#769ff0";
      t_primary = "#1E202E";
      t_secondary = "#7892DA";
      t_tertiary = "#D9DBE3";
    };

    os = {
      disabled = false;
      format = "[  $symbol  ](bg:v_primary fg:t_primary)";
      symbols = {
        Arch = "";
        CentOS = "";
        Debian = "";
        Fedora = "";
        FreeBSD = "";
        Gentoo = "";
        Linux = "";
        Macos = "";
        Mint = "";
        NixOS = "";
        Ubuntu = "";
        Unknown = "";
        Windows = "";
      };
    };

    localip = {
      ssh_only = true;
      format = "[ $localipv4 ](bg:v_primary fg:t_primary bold)";
      disabled = false;
    };

    directory = {
      format = "[  $path ](bg:v_secondary fg:t_secondary)";
      truncation_length = 3;
      truncation_symbol = "…/";
      substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Pictures" = " ";
      };
    };

    git_branch = {
      symbol = "";
      format = "[[$symbol $branch ](fg:git-green bg:v_base bold)](bg:v_base)";
    };

    git_status = {
      format = "[[($all_status$ahead_behind )](fg:t_base bg:v_base)](bg:v_base$style)";
    };

    aws = {
      disabled = true;
    };
    docker_context = {
      disabled = true;
    };
    gcloud = {
      disabled = true;
    };
    memory_usage = {
      disabled = true;
      threshold = -1;
      style = "bold dimmed green";
    };
    sudo = {
      disabled = false;
    };
    vagrant = {
      disabled = true;
    };
  };
in
{
  programs.starship = {
    enable = true;
    settings = if useTokyoNight then tokyoNightSettings else defaultSettings;
  };
}
