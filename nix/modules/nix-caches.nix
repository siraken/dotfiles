# Binary cache configuration
# Determinate Nix Installer の設定が nix-darwin に上書きされるため明示的に指定
let
  caches = import ./nix-cache-list.nix;
in
{
  nix.settings = {
    inherit (caches) substituters trusted-public-keys;
    always-allow-substitutes = true;
  };
}
