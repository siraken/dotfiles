{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    silent = false;
    nix-direnv.enable = true;
    config = {
      # load_dotenv = true;
      strict_env = true;
      warn_timeout = "10s";
    };
    mise = {
      enable = false;
    };
  };
}
