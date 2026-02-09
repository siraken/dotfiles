{ pkgs, ... }:
{
  programs.openclaw = {
    enable = true;
    stateDir = "~/.openclaw";
    workspaceDir = "~/.openclaw/workspace";
  };
}
