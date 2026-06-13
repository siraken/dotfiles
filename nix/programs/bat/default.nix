{ mkRepoLink, ... }:
{
  programs.bat.enable = true;

  # Static config lives in a repo file linked in place, so it is editable
  # without a rebuild. The bat module only generates ~/.config/bat/config when
  # `config` is non-empty, so dropping it leaves the path free to link. See #70.
  xdg.configFile."bat/config".source = mkRepoLink "config/bat/config";
}
