{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper= {
      hosts = ["https://github.com" "https://gist.github.com"];
    };
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      git_protocol = "https";
    };
  };
}
