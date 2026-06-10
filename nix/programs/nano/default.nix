{ mkRepoLink, ... }:
{
  home.file.".config/nano/nanorc".source = mkRepoLink "nix/programs/nano/nanorc";
}
