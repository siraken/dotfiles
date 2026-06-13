{ mkRepoLink, ... }:
{
  programs.fastfetch.enable = true;

  # Static config lives in a repo file linked in place, so it is editable
  # without a rebuild. The fastfetch module only generates config.jsonc when
  # `settings` is non-empty, so dropping it leaves the path free to link.
  # See #70.
  xdg.configFile."fastfetch/config.jsonc".source = mkRepoLink "config/fastfetch/config.jsonc";
}
