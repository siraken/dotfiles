{
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    inputs.openclaw.homeManagerModules.openclaw
  ];

  programs.nix-index-database.comma.enable = true;
}
