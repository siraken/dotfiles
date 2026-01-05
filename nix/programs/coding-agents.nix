{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;
  };

  programs.codex = {
    enable = true;
  };

  programs.gemini-cli = {
    enable = true;
    commands = { };
    settings = {
      contextFileName = "AGENTS.md";
      general = {
        preferredEditor = "nvim";
      };
      ide = {
        enabled = true;
      };
      privacy = {
        usageStatisticsEnabled = false;
      };
      security = {
        auth = {
          selectedType = "oauth-personal";
        };
      };
      ui = {
        theme = "GitHub";
      };
    };
  };

  programs.opencode = {
    enable = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      theme = "tokyonight";
      formatter = {
        prettier = {
          disabled = true;
        };
      };
    };
  };
}
