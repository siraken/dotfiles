{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.path;
in
{
  options.dotfiles.path = {
    enable = lib.mkEnableOption "shared session path";
    extraPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional paths to add to session path";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionPath = [
      "/opt/homebrew/opt/openssl@3/bin" # Use openssl installed by homebrew
      "/opt/homebrew/sbin"
      "/opt/homebrew/bin"
      "bin"
      "$HOME/bin"
      "$HOME/.local/bin"
      "$HOME/.local/share/mise/shims"
      "$HOME/.progate/bin"
      "$HOME/.slack/bin"
      "$HOME/Library/Application Support/Coursier/bin"
      "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
      "$HOME/Library/Android/sdk/platform-tools"
      "$HOME/.pub-cache/bin"
      "$HOME/Developer/flutter/bin"
      "$HOME/.deno/bin"
      "$HOME/.cargo/bin"
      "$HOME/.rye/shims"
      "$COMPOSER_HOME/vendor/bin"
      "$HOME/go/bin"
      "$HOME/.bun/bin"
    ]
    ++ cfg.extraPaths;
  };
}
