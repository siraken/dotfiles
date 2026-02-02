# Custom launchd services module
# Usage: Define services in customServices attribute set
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.customServices;
  homeDir = config.users.users.siraken.home;
  logDir = "${homeDir}/.local/log";

  # Service options type
  serviceOpts = { name, ... }: {
    options = {
      enable = mkEnableOption "Enable ${name} service";

      package = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "The package providing the service (optional)";
      };

      command = mkOption {
        type = types.listOf types.str;
        description = "Command and arguments to run";
      };

      environment = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = "Environment variables";
      };

      workingDirectory = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Working directory for the service";
      };

      runAtLoad = mkOption {
        type = types.bool;
        default = true;
        description = "Start service at login";
      };

      keepAlive = mkOption {
        type = types.bool;
        default = true;
        description = "Restart service if it exits";
      };

      startInterval = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Run service every N seconds (mutually exclusive with keepAlive)";
      };
    };
  };

  # Convert service config to launchd format
  mkLaunchdService = name: opts: {
    serviceConfig = {
      Label = "org.nixos.${name}";
      ProgramArguments = opts.command;
      RunAtLoad = opts.runAtLoad;
      KeepAlive = opts.keepAlive;
      StandardOutPath = "${logDir}/${name}.log";
      StandardErrorPath = "${logDir}/${name}.log";
    }
    // optionalAttrs (opts.environment != { }) {
      EnvironmentVariables = opts.environment;
    }
    // optionalAttrs (opts.workingDirectory != null) {
      WorkingDirectory = opts.workingDirectory;
    }
    // optionalAttrs (opts.startInterval != null) {
      StartInterval = opts.startInterval;
    };
  };

  # Get packages from enabled services
  enabledServices = filterAttrs (n: v: v.enable) cfg;
  servicePackages = filter (p: p != null) (mapAttrsToList (n: v: v.package) enabledServices);

in
{
  options.customServices = mkOption {
    type = types.attrsOf (types.submodule serviceOpts);
    default = { };
    description = "Custom launchd services";
  };

  config = mkIf (cfg != { }) {
    # Create log directory via launchd oneshot or manual setup
    # Note: Directory creation is handled by the service itself or user

    # Add packages to system
    environment.systemPackages = servicePackages;

    # Register enabled services with launchd
    launchd.user.agents = mapAttrs mkLaunchdService enabledServices;
  };
}
