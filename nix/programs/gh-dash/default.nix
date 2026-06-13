{ lib, mkRepoLink, ... }:
{
  programs.gh-dash.enable = true;

  # Static config lives in a repo file linked in place, so it is editable
  # without a rebuild. The gh-dash module sets config.yml's source
  # unconditionally, so override it with mkForce to point at the repo. See #70.
  xdg.configFile."gh-dash/config.yml".source = lib.mkForce (mkRepoLink "config/gh-dash/config.yml");
}
