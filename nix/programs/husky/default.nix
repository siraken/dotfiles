{ mkRepoLink, ... }:
{
  home.file.".config/husky/init.sh".source = mkRepoLink "nix/programs/husky/init.sh";
}
