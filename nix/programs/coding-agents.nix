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
}
