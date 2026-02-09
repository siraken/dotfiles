{ pkgs, ... }:
{
  programs.openclaw = {
    enable = true;
    stateDir = "~/.openclaw";
    workspaceDir = "~/.openclaw/workspace";
    # Workaround: nix-openclaw defaultInstance in config.nix lacks nixMode,
    # so we explicitly define an instance to avoid the missing attribute error.
    instances.default = {
      enable = true;
    };
  };
}
