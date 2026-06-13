{ mkRepoLink, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  # Static prompt config lives in a repo file linked in place, so it is
  # editable without a rebuild. The starship module only generates
  # starship.toml when `settings`/`presets` are non-empty, so dropping
  # `settings` leaves the path free to link. Shell integration stays in Nix.
  # See #70.
  xdg.configFile."starship.toml".source = mkRepoLink "config/starship/starship.toml";
}
