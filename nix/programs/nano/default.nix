{ mkRepoLink, ... }:
{
  home.file.".config/nano/nanorc".source = mkRepoLink "config/nano/nanorc";
}
