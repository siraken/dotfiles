{ pkgs, ... }:
{
  programs.openclaw = {
    enable = true;
    stateDir = "~/.openclaw";
    workspaceDir = "~/.openclaw/workspace";
    config = {
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

    # Workaround: nix-openclaw defaultInstance in config.nix lacks nixMode,
    # so we explicitly define an instance to avoid the missing attribute error.
    instances.default = {
      enable = true;
    };
  };
}
