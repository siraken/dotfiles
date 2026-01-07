{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      dialect = "us";
      auto_sync = true;
      search_mode = "fuzzy";
      style = "full";
      invert = true;
      show_preview = true;
      exit_mode = "return-query"; # return-original or return-query
      secrets_filter = true;
      theme = {
        name = "autumn";
        debug = false;
        max_depth = 10;
      };
    };
    # daemon = {
    #   enable = true;
    # };
  };
}
