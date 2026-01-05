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
  };

  programs.opencode = {
    enable = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      theme = "tokyonight";
    };
  };
}
