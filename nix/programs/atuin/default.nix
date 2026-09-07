{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    # atuin 18.19 以降は `?` を AI 起動ウィジェットに bind するため、
    # URL のクエリ文字列などで `?` が打てなくなる。bind だけ外す
    # (`atuin ai inline` は引き続き手動で呼べる)
    flags = [ "--disable-ai" ];

    settings = {
      dialect = "us";
      auto_sync = true;
      search_mode = "fuzzy";
      style = "full";
      invert = false;
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
