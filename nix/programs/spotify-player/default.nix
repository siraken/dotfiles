{ mkRepoLink, ... }:
{
  programs.spotify-player.enable = true;

  # Static settings live in a repo file linked in place, so they are editable
  # without a rebuild. The spotify-player module only generates app.toml when
  # `settings` is non-empty, so dropping it leaves the path free to link. See #70.
  xdg.configFile."spotify-player/app.toml".source = mkRepoLink "config/spotify-player/app.toml";
}
