{
  config,
  pkgs,
  lib,
  dotfilesPath,
}:
{
  createSymlinksForAgents = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bash}/bin/bash ${dotfilesPath}/symlink
  '';
}
