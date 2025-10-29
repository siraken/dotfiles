{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles = {
      Default = {
        languageSnippets = {};
      };
    };
  };
}
