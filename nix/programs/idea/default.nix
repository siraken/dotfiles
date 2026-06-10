{ mkRepoLink, ... }:
{
  home.file.".ideavimrc".source = mkRepoLink "home/.ideavimrc";
}
