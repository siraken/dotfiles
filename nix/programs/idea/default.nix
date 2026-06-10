{ mkRepoLink, ... }:
{
  home.file.".ideavimrc".source = mkRepoLink "nix/programs/idea/.ideavimrc";
}
