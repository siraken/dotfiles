# GitHub CLI. Split out of the git module so the `base` profile (production
# servers) gets git without gh and its extensions.
{ pkgs, mkRepoLink, ... }:
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
    # Every gh extension is listed here. gh-dash is deliberately not enabled
    # through `programs.gh-dash`: that module appends itself to this list from
    # elsewhere, and its only other job (writing config.yml) is replaced by the
    # repo link below anyway.
    extensions = with pkgs; [
      gh-actions-lock
      gh-aw
      gh-dash
      gh-markdown-preview
      gh-poi
      gh-skyline
      gh-stack
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

  # gh-dash's static config lives in a repo file linked in place, so it is
  # editable without a rebuild.
  xdg.configFile."gh-dash/config.yml".source = mkRepoLink "config/gh-dash/config.yml";
}
