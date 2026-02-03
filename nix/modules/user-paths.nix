# User directory path helpers
# Provides XDG Base Directory compliant path generation
#
# Usage:
#   let
#     userPaths = import ../modules/user-paths.nix { inherit homeDir; };
#   in {
#     dataDir = userPaths.data "postgresql";  # -> /Users/siraken/.local/share/postgresql
#   }
{ homeDir }:

let
  # XDG Base Directories
  configBase = "${homeDir}/.config";
  dataBase = "${homeDir}/.local/share";
  stateBase = "${homeDir}/.local/state";
  cacheBase = "${homeDir}/.cache";
  logBase = "${homeDir}/.local/log";

  # Helper function to create path with optional subdirectory
  mkPath = base: app: if app == null || app == "" then base else "${base}/${app}";
in
{
  # Home directory
  home = homeDir;

  # XDG Base Directories (raw paths)
  configBase = configBase;
  dataBase = dataBase;
  stateBase = stateBase;
  cacheBase = cacheBase;
  logBase = logBase;

  # Path generators with app subdirectory
  # Usage: userPaths.config "nvim" -> ~/.config/nvim
  config = app: mkPath configBase app;
  data = app: mkPath dataBase app;
  state = app: mkPath stateBase app;
  cache = app: mkPath cacheBase app;
  log = app: mkPath logBase app;

  # Convenience aliases for common patterns
  # Usage: userPaths.dataDir "postgresql" -> ~/.local/share/postgresql
  configDir = app: mkPath configBase app;
  dataDir = app: mkPath dataBase app;
  stateDir = app: mkPath stateBase app;
  cacheDir = app: mkPath cacheBase app;
  logDir = app: mkPath logBase app;
}
