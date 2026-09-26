# GitHub CLI. Split out of the git module so the `base` profile (production
# servers) gets git without gh and its extensions.
{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    extensions = with pkgs; [
      gh-markdown-preview
    ];
    settings = {
      aliases = {
        as = "auth status";
        co = "pr checkout";
        pv = "pr view";
        sw = "auth switch";
      };
      git_protocol = "https";
    };
  };
}
