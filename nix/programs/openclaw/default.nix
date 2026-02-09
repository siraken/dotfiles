{ pkgs, ... }:
let
  openclawConfig = {
    gateway = {
      mode = "local";
      port = 18789;
      bind = "loopback";
      tailscale = {
        mode = "serve";
        resetOnExit = false;
      };
    };

    auth = {
      profiles = {
        "anthropic:openclaw" = {
          provider = "anthropic";
          mode = "token";
        };
      };
    };

    plugins = {
      entries = {
        slack = {
          enabled = true;
        };
      };
    };

    channels = {
      slack = {
        enabled = true;
        groupPolicy = "allowlist";
        channels = {
          "#dev-openclaw" = {
            allow = true;
          };
        };
      };
    };

    skills = {
      install = {
        nodeManager = "pnpm";
      };
    };
  };
in
{
  programs.openclaw = {
    enable = true;
    stateDir = "~/.openclaw";
    workspaceDir = "~/.openclaw/workspace";
    config = openclawConfig;
    # Workaround: nix-openclaw defaultInstance in config.nix lacks nixMode,
    # so we explicitly define an instance with config to ensure JSON output.
    instances.default = {
      enable = true;
      config = openclawConfig;
    };
  };
}
