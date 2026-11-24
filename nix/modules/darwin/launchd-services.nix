# Custom launchd services module
# Usage: Define services in customServices attribute set
{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.customServices;
  user = config.system.primaryUser;
  homeDir = config.users.users.${user}.home;
  userPaths = import ../user-paths.nix { inherit homeDir; };
  logDir = userPaths.logBase;

  # Service options type
  serviceOpts =
    { name, config, ... }:
    {
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
          default = config.startInterval == null;
          defaultText = literalExpression "config.startInterval == null";
          description = "Restart service if it exits (mutually exclusive with startInterval)";
        };

        startInterval = mkOption {
          type = types.nullOr types.ints.positive;
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
      StandardOutPath = "${logDir}/${name}.log";
      StandardErrorPath = "${logDir}/${name}.log";
    }
    // optionalAttrs (opts.startInterval == null) {
      KeepAlive = opts.keepAlive;
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

  config = mkIf (enabledServices != { }) {
    assertions = mapAttrsToList (name: opts: {
      assertion = !(opts.keepAlive && opts.startInterval != null);
      message = "customServices.${name}: keepAlive and startInterval are mutually exclusive";
    }) enabledServices;

    # Ensure the log directory exists before launchd loads user agents, owned by primaryUser.
    system.activationScripts.userLaunchd.text = mkBefore ''
      sudo --user=${escapeShellArg user} -- mkdir -p ${escapeShellArg logDir}
    '';

    # Add packages to system
    environment.systemPackages = servicePackages;

    # Register enabled services with launchd
    launchd.user.agents = mapAttrs mkLaunchdService enabledServices;
  };
}
