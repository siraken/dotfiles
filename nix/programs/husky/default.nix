{ mkRepoLink, ... }:
{
  home.file.".config/husky/init.sh".source = mkRepoLink "config/husky/init.sh";
}
