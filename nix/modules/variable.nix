{
  config,
  lib,
  ...
}:
let
  cfg = config.dotfiles.variables;
in
{
  options.dotfiles.variables = {
    enable = lib.mkEnableOption "shared session variables";
    extraVariables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Additional session variables to merge";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      BASH_SILENCE_DEPRECATION_WARNING = "1";
      CLICOLOR = "true";
      TERM = "xterm-256color";
      EDITOR = "nvim";
      GH_URL = "https://github.com";
      AWS_PROFILE = "default";
      AWS_DEFAULT_REGION = "ap-northeast-1";

      XDG_CONFIG_HOME = "$HOME/.config";
      SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
      GOPATH = "$HOME/go";
      MODULAR_HOME = "$HOME/.modular";
      COMPOSER_HOME = "$XDG_CONFIG_HOME/composer";
      BUN_INSTALL = "$HOME/.bun";
      JAVA_HOME = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home";
    }
    // cfg.extraVariables;
  };
}
